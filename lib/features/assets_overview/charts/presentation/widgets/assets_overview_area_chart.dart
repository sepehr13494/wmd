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
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';

import 'chart_custom_tooltip.dart';
import 'constants.dart';

class AssetsOverviewAreaChart extends StatefulWidget {
  final List<GetChartEntity> getChartEntities;
  final List<String> titles;
  final bool showPercentage;
  const AssetsOverviewAreaChart(
      {super.key,
      required this.getChartEntities,
      required this.titles,
      this.showPercentage = false});

  @override
  State<AssetsOverviewAreaChart> createState() =>
      _AssetsOverviewAreaChartState();
}

class _AssetsOverviewAreaChartState extends State<AssetsOverviewAreaChart> {
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
          LineChart(
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
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: PrivacyBlurWidget(
        child: Builder(builder: (context) {
          late String text;
          if (widget.showPercentage) {
            text = "${(((value * x) / maxY) * 100).toStringAsFixed(1)} %";
          } else {
            text = (value * x).formatNumberWithDecimal();
          }
          return Text(
            text,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 10),
          );
        }),
      ),
    );
  }

  LineChartData mainData(context) {
    double minY = calculateMinMax(widget.getChartEntities)[0];
    double maxY = calculateMinMax(widget.getChartEntities)[1];
    double x = max(maxY.abs(), minY.abs()) / 5;
    minY = (minY / x);
    maxY = (maxY / x);
    double maxTotal = max(minY.abs(), maxY.abs());
    return LineChartData(
        lineTouchData: LineTouchData(
          touchCallback: (p0, p1) {
            if (p1 != null) {
              if (p1.lineBarSpots != null) {
                setState(() {
                  selected =
                      widget.getChartEntities[p1.lineBarSpots!.first.spotIndex];
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
          touchTooltipData: LineTouchTooltipData(
            fitInsideVertically: true,
            fitInsideHorizontally: true,
            getTooltipItems: (touchedSpots) {
              return List.generate(touchedSpots.length, (index) {
                return null;
              });
            },
            maxContentWidth: 300,
            tooltipBgColor: AppColors.blueCardColor,
          ),
        ),
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
        minX: 0,
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
        lineBarsData: getData(x));
  }

  List<LineChartBarData> getData(double x) {
    return List.generate(widget.titles.length, (mainIndex) {
      Color color = Colors.transparent;
      switch (widget.titles[mainIndex]) {
        case AssetTypes.bankAccount:
          color =
              AssetsOverviewChartsColors.colorsMap[AssetTypes.bankAccount] ??
                  Colors.brown;
          break;
        case AssetTypes.privateEquity:
          color =
              AssetsOverviewChartsColors.colorsMap[AssetTypes.privateEquity] ??
                  Colors.brown;
          break;
        case AssetTypes.privateDebt:
          color =
              AssetsOverviewChartsColors.colorsMap[AssetTypes.privateDebt] ??
                  Colors.brown;
          break;
        case AssetTypes.realEstate:
          color = AssetsOverviewChartsColors.colorsMap[AssetTypes.realEstate] ??
              Colors.brown;
          break;
        case AssetTypes.listedAssetEquity:
          color = AssetsOverviewChartsColors
                  .colorsMap[AssetTypes.listedAssetEquity] ??
              Colors.brown;
          break;
        case AssetTypes.listedAssetFixedIncome:
          color = AssetsOverviewChartsColors
                  .colorsMap[AssetTypes.listedAssetFixedIncome] ??
              Colors.brown;
          break;
        case AssetTypes.listedAssetOther:
          color = AssetsOverviewChartsColors
                  .colorsMap[AssetTypes.listedAssetOther] ??
              Colors.brown;
          break;
        case AssetTypes.otherAsset:
          color = AssetsOverviewChartsColors.colorsMap[AssetTypes.otherAsset] ??
              Colors.brown;
          break;
      }
      return LineChartBarData(
        isCurved: false,
        color: color,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        spots: List.generate(widget.getChartEntities.length, (index) {
          GetChartEntity getChartEntity = widget.getChartEntities[index];
          double y = 0;
          switch (widget.titles[mainIndex]) {
            case AssetTypes.bankAccount:
              y = getChartEntity.bankAccount / x;
              break;
            case AssetTypes.privateEquity:
              y = getChartEntity.privateEquity / x;
              break;
            case AssetTypes.privateDebt:
              y = getChartEntity.privateDebt / x;
              break;
            case AssetTypes.realEstate:
              y = getChartEntity.realEstate / x;
              break;
            case AssetTypes.listedAssetEquity:
              y = getChartEntity.listedAssetEquity / x;
              break;
            case AssetTypes.listedAssetFixedIncome:
              y = getChartEntity.listedAssetFixedIncome / x;
              break;
            case AssetTypes.listedAssetOther:
              y = getChartEntity.listedAssetOther / x;
              break;
            case AssetTypes.otherAsset:
              y = getChartEntity.others / x;
              break;
          }
          return FlSpot(index.toDouble(), y);
        }),
        belowBarData: BarAreaData(
          show: true,
          cutOffY: 0,
          applyCutOffY: true,
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                color.withOpacity(0.4),
                color.withOpacity(0.0),
              ]),
        ),
      );
    });
  }

  calculateMinMax(List<GetChartEntity> getChartEntities) {
    double minY = 0;
    double maxY = 0;
    if (getChartEntities.isNotEmpty) {
      for (var element in getChartEntities) {
        if (element.bankAccount > maxY) {
          maxY = element.bankAccount;
        }
        if (element.listedAssetEquity > maxY) {
          maxY = element.listedAssetEquity;
        }
        if (element.listedAssetFixedIncome > maxY) {
          maxY = element.listedAssetFixedIncome;
        }
        if (element.listedAssetOther > maxY) {
          maxY = element.listedAssetOther;
        }
        if (element.others > maxY) {
          maxY = element.others;
        }
        if (element.privateDebt > maxY) {
          maxY = element.privateDebt;
        }
        if (element.realEstate > maxY) {
          maxY = element.realEstate;
        }
        if (element.privateEquity > maxY) {
          maxY = element.privateEquity;
        }
      }
    }
    return [minY, maxY];
  }
}
