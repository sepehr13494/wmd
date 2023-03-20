import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/assets_overview/charts/domain/entities/get_chart_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/chart_custom_tooltip.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';

import 'constants.dart';

class AssetsOverviewBarCharts extends StatefulWidget {
  final List<GetChartEntity> getChartEntities;

  const AssetsOverviewBarCharts({super.key, required this.getChartEntities});

  @override
  State<AssetsOverviewBarCharts> createState() =>
      _AssetsOverviewBarChartsState();
}

class _AssetsOverviewBarChartsState extends State<AssetsOverviewBarCharts> {
  Timer? _timer;
  bool showTooltip = false;
  GetChartEntity? selected;
  double position = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, snap) {
      final width = (snap.maxWidth - 100);
      final x = (position - width / 2) / (width / 2);
      var pos = x;
      if (x < -1) {
        pos = -1;
      } else if (x > 1) {
        pos = 1;
      }
      return Stack(
        alignment: Alignment(pos, -1),
        children: [
          BarChart(
            mainData(context),
          ),
          showTooltip
              ? ChartCustomTooltip(selected: selected)
              : const SizedBox(),
        ],
      );
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    int x = (widget.getChartEntities.length / 7).ceil();
    var dateString = widget.getChartEntities[value.toInt()].date.split("/");
    DateTime dateTime = DateTime(int.parse(dateString[2]),
        int.parse(dateString[0]), int.parse(dateString[1]));
    return value.toInt() % x == 0
        ? SideTitleWidget(
            axisSide: meta.axisSide,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(CustomizableDateTime.localizedDdMm(dateTime),
                  style: const TextStyle(fontSize: 8)),
            ),
          )
        : const SizedBox();
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    double minY = calculateMinMax(widget.getChartEntities)[0];
    double maxY = calculateMinMax(widget.getChartEntities)[1];
    double x = max(maxY.abs(), minY.abs()) / 5;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: PrivacyBlurWidget(
          child: Text(
            "\$ ${(value * x).formatNumber}",
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 10),
          ),
        ),
      ),
    );
  }

  BarChartData mainData(context) {
    double minY = calculateMinMax(widget.getChartEntities)[0];
    double maxY = calculateMinMax(widget.getChartEntities)[1];
    double x = max(maxY.abs(), minY.abs()) / 5;
    minY = (minY / x);
    maxY = (maxY / x);
    double maxTotal = max(minY.abs(), maxY.abs());
    return BarChartData(
        barTouchData: BarTouchData(
            touchCallback: (p0, p1) {
              if (p1 != null) {
                if (p1.spot != null) {
                  setState(() {
                    selected =
                        widget.getChartEntities[p1.spot!.touchedBarGroupIndex];
                    position = p0.localPosition!.dx;
                    showTooltip = true;
                    if (_timer != null) {
                      _timer!.cancel();
                    }
                    _timer = Timer(const Duration(seconds: 2), () {
                      setState(() {
                        showTooltip = false;
                      });
                    });
                  });
                }
              }
            },
            touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem("", const TextStyle());
                },
                tooltipPadding: EdgeInsets.all(0.5))),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 1,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: AppColors.dashBoardGreyTextColor,
              strokeWidth: 0.3,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Theme.of(context).cardColor,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: bottomTitleWidgets,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: leftTitleWidgets,
              reservedSize: 42,
            ),
          ),
        ),
        borderData: FlBorderData(
            show: true,
            border: const Border.symmetric(
                horizontal: BorderSide(
                    width: 0.3, color: AppColors.dashBoardGreyTextColor))),
        minY: minY.abs() == maxTotal
            ? minY
            : minY >= 0
                ? 0
                : (-(minY.abs()).ceil().toDouble()),
        maxY: maxY.abs() == maxTotal
            ? maxY
            : maxY <= 0
                ? 0
                : (maxY.abs()).ceil().toDouble(),
        barGroups: getData(x));
  }

  List<BarChartGroupData> getData(double x) {
    return List.generate(widget.getChartEntities.length, (index) {
      GetChartEntity getChartEntity = widget.getChartEntities[index];
      final double sum = getChartEntity.privateEquity +
          getChartEntity.realEstate +
          getChartEntity.privateDebt +
          getChartEntity.others +
          getChartEntity.bankAccount +
          getChartEntity.listedAssetEquity +
          getChartEntity.listedAssetFixedIncome +
          getChartEntity.listedAssetOther;
      final bankList =
          getChartEntity.bankAccount / x + getChartEntity.listedAssetEquity / x;
      final bankListEquity = bankList + getChartEntity.privateEquity / x;
      final bankListEquityDept =
          bankListEquity + getChartEntity.privateDebt / x;
      final bankListEquityDeptEstate =
          bankListEquityDept + getChartEntity.realEstate / x;
      final bankListEquityDeptEstateFix =
          bankListEquityDeptEstate + getChartEntity.listedAssetFixedIncome / x;
      final bankListEquityDeptEstateFixOther =
          bankListEquityDeptEstateFix + getChartEntity.listedAssetOther / x;
      return BarChartGroupData(
        x: index,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            borderSide: BorderSide(color: Theme.of(context).cardColor),
            toY: sum / x,
            rodStackItems: [
              BarChartRodStackItem(
                  0,
                  getChartEntity.bankAccount / x,
                  AssetsOverviewChartsColors
                          .colorsMap[AssetTypes.bankAccount] ??
                      Colors.brown),
              BarChartRodStackItem(
                  getChartEntity.bankAccount / x,
                  bankList,
                  AssetsOverviewChartsColors
                          .colorsMap[AssetTypes.listedAssetEquity] ??
                      Colors.brown),
              BarChartRodStackItem(
                  bankList,
                  bankListEquity,
                  AssetsOverviewChartsColors
                          .colorsMap[AssetTypes.privateEquity] ??
                      Colors.brown),
              BarChartRodStackItem(
                  bankListEquity,
                  bankListEquityDept,
                  AssetsOverviewChartsColors
                          .colorsMap[AssetTypes.privateDebt] ??
                      Colors.brown),
              BarChartRodStackItem(
                  bankListEquityDept,
                  bankListEquityDeptEstate,
                  AssetsOverviewChartsColors.colorsMap[AssetTypes.realEstate] ??
                      Colors.brown),
              BarChartRodStackItem(
                  bankListEquityDeptEstate,
                  bankListEquityDeptEstateFix,
                  AssetsOverviewChartsColors
                          .colorsMap[AssetTypes.listedAssetFixedIncome] ??
                      Colors.brown),
              BarChartRodStackItem(
                  bankListEquityDeptEstateFix,
                  bankListEquityDeptEstateFixOther,
                  AssetsOverviewChartsColors
                          .colorsMap[AssetTypes.listedAssetOther] ??
                      Colors.brown),
              BarChartRodStackItem(
                  bankListEquityDeptEstateFixOther,
                  sum / x,
                  AssetsOverviewChartsColors.colorsMap[AssetTypes.otherAsset] ??
                      Colors.brown),
            ],
            borderRadius: BorderRadius.zero,
          ),
        ],
      );
    });
  }

  calculateMinMax(List<GetChartEntity> getChartEntities) {
    double minY = 0;
    double maxY = 0;
    if (getChartEntities.isNotEmpty) {
      maxY += getChartEntities[0].bankAccount;
      maxY += getChartEntities[0].listedAssetEquity;
      maxY += getChartEntities[0].listedAssetFixedIncome;
      maxY += getChartEntities[0].listedAssetOther;
      maxY += getChartEntities[0].others;
      maxY += getChartEntities[0].privateDebt;
      maxY += getChartEntities[0].realEstate;
      maxY += getChartEntities[0].privateEquity;
      for (var element in getChartEntities) {
        double maxY2 = 0;
        maxY2 += element.bankAccount;
        maxY2 += element.listedAssetEquity;
        maxY2 += element.listedAssetFixedIncome;
        maxY2 += element.listedAssetOther;
        maxY2 += element.others;
        maxY2 += element.privateDebt;
        maxY2 += element.realEstate;
        maxY2 += element.privateEquity;
        if (maxY2 > maxY) {
          maxY = maxY2;
        }
      }
    }
    return [minY, maxY];
  }
}
