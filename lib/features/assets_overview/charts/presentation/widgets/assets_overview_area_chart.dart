import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/assets_overview/charts/domain/entities/get_chart_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'constants.dart';

class AssetsOverviewAreaChart extends StatelessWidget {
  final List<GetChartEntity> getChartEntities;
  const AssetsOverviewAreaChart({super.key, required this.getChartEntities});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      mainData(context),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    int x = (getChartEntities.length/7).ceil();
    var dateString = getChartEntities[value.toInt()].date.split("/");
    DateTime dateTime = DateTime(int.parse(dateString[2]),int.parse(dateString[0]),int.parse(dateString[1]));
    return value.toInt() % x == 0 ? SideTitleWidget(
      axisSide: meta.axisSide,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Text(
            CustomizableDateTime.localizedDdMm(dateTime),
            style: const TextStyle(fontSize: 8)),
      ),
    ) : const SizedBox();
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    double minY = calculateMinMax(getChartEntities)[0];
    double maxY = calculateMinMax(getChartEntities)[1];
    double x = max(maxY.abs() , minY.abs()) / 5;
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        "\$ ${(value * x).formatNumber}",
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 10),
      ),
    );
  }

  LineChartData mainData(context) {
    double minY = calculateMinMax(getChartEntities)[0];
    double maxY = calculateMinMax(getChartEntities)[1];
    double x = max(maxY.abs() , minY.abs()) / 5;
    minY = (minY/x);
    maxY = (maxY/x);
    double maxTotal = max(minY.abs(), maxY.abs());
    return LineChartData(
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            fitInsideVertically: true,
            fitInsideHorizontally: true,
            getTooltipItems: (touchedSpots) {
              final textTheme = Theme.of(context).textTheme;
              final getChartEntity = getChartEntities[touchedSpots.first.x.toInt()];
              final double sum =
                  getChartEntity.privateEquity+
                      getChartEntity.realEstate+
                      getChartEntity.privateDebt+
                      getChartEntity.others+
                      getChartEntity.bankAccount+
                      getChartEntity.listedAssetEquity+
                      getChartEntity.listedAssetFixedIncome+
                      getChartEntity.listedAssetEquity;
              final appLocalizations = AppLocalizations.of(context);
              return [LineTooltipItem(
                "${CustomizableDateTime.miniDateWithYear(getChartEntity.date)}\n",
                textTheme.titleSmall!,
                textAlign: TextAlign.start,
                children: [
                  getChartEntity.bankAccount != 0 ? TextSpan(
                      style: textTheme.bodyMedium,children: [TextSpan(text: "\n" + AssetsOverviewChartsColors.getAssetType(
                    appLocalizations,
                    "Bank Account".replaceAll(" ", ""),
                  ) + "\t\t"),TextSpan(text: getChartEntity.bankAccount.formatNumberWithDecimal(),style: const TextStyle(color: AppColors.chartColor))]) : const TextSpan(),
                  getChartEntity.privateEquity != 0 ? TextSpan(
                      style: textTheme.bodyMedium,children: [TextSpan(text: "\n" + AssetsOverviewChartsColors.getAssetType(
                    appLocalizations,
                    "Private Equity".replaceAll(" ", ""),
                  ) + "\t\t"),TextSpan(text: getChartEntity.privateEquity.formatNumberWithDecimal(),style: const TextStyle(color: AppColors.chartColor))]) : const TextSpan(),
                  getChartEntity.privateDebt != 0 ? TextSpan(
                      style: textTheme.bodyMedium,children: [TextSpan(text: "\n" + AssetsOverviewChartsColors.getAssetType(
                    appLocalizations,
                    "Private Debt".replaceAll(" ", ""),
                  ) + "\t\t"),TextSpan(text: getChartEntity.privateDebt.formatNumberWithDecimal(),style: const TextStyle(color: AppColors.chartColor))]) : const TextSpan(),
                  getChartEntity.realEstate != 0 ? TextSpan(
                      style: textTheme.bodyMedium,children: [TextSpan(text: "\n" + AssetsOverviewChartsColors.getAssetType(
                    appLocalizations,
                    "Real Estate".replaceAll(" ", ""),
                  ) + "\t\t"),TextSpan(text: getChartEntity.realEstate.formatNumberWithDecimal(),style: const TextStyle(color: AppColors.chartColor))]) : const TextSpan(),
                  getChartEntity.listedAssetEquity != 0 ? TextSpan(
                      style: textTheme.bodyMedium,children: [TextSpan(text: "\n" + AssetsOverviewChartsColors.getAssetType(
                    appLocalizations,
                    AssetTypes.listedAssetEquity.replaceAll(" ", ""),
                  ) + "\t\t"),TextSpan(text: getChartEntity.listedAssetEquity.formatNumberWithDecimal(),style: const TextStyle(color: AppColors.chartColor))]) : const TextSpan(),
                  getChartEntity.listedAssetFixedIncome != 0 ? TextSpan(
                      style: textTheme.bodyMedium,children: [TextSpan(text: "\n" + AssetsOverviewChartsColors.getAssetType(
                    appLocalizations,
                    AssetTypes.listedAssetFixedIncome.replaceAll(" ", ""),
                  ) + "\t\t"),TextSpan(text: getChartEntity.listedAssetFixedIncome.formatNumberWithDecimal(),style: const TextStyle(color: AppColors.chartColor))]) : const TextSpan(),
                  getChartEntity.listedAssetOther != 0 ? TextSpan(
                      style: textTheme.bodyMedium,children: [TextSpan(text: "\n" + AssetsOverviewChartsColors.getAssetType(
                    appLocalizations,
                    AssetTypes.listedAssetOther.replaceAll(" ", ""),
                  ) + "\t\t"),TextSpan(text: getChartEntity.listedAssetOther.formatNumberWithDecimal(),style: const TextStyle(color: AppColors.chartColor))]) : const TextSpan(),
                  getChartEntity.others != 0 ? TextSpan(
                      style: textTheme.bodyMedium,children: [TextSpan(text: "\n" + AssetsOverviewChartsColors.getAssetType(
                    appLocalizations,
                    "Other Assets".replaceAll(" ", ""),
                  ) + "\t"),TextSpan(text: getChartEntity.others.formatNumberWithDecimal(),style: const TextStyle(color: AppColors.chartColor))]) : const TextSpan(),
                ],
              )];
            },
            maxContentWidth: 200,
            tooltipBgColor: const Color.fromARGB(255, 38, 49, 52),
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
        minY: minY.abs() == maxTotal ? minY : minY >= 0 ? 0 : (- (minY.abs()).ceil().toDouble()),
        maxY: maxY.abs() == maxTotal ? maxY : maxY <= 0 ? 0 : (maxY.abs()).ceil().toDouble(),
        lineBarsData: getData(x)
    );
  }

  List<LineChartBarData> getData(double x) {
    return List.generate(9, (mainIndex) {
      Color color = Colors.white;
      switch (mainIndex){
        case 0:
          color = AssetsOverviewChartsColors.colorsMap[AssetTypes.bankAccount]??Colors.brown;
          break;
        case 1:
          color = AssetsOverviewChartsColors.colorsMap[AssetTypes.privateEquity]??Colors.brown;
          break;
        case 2:
          color = AssetsOverviewChartsColors.colorsMap[AssetTypes.privateDebt]??Colors.brown;
          break;
        case 3:
          color =AssetsOverviewChartsColors.colorsMap[AssetTypes.realEstate]??Colors.brown;
          break;
        case 4:
          color = AssetsOverviewChartsColors.colorsMap[AssetTypes.listedAssetEquity]??Colors.brown;
          break;
        case 5:
          color = AssetsOverviewChartsColors.colorsMap[AssetTypes.listedAssetFixedIncome]??Colors.brown;
          break;
        case 6:
          color = AssetsOverviewChartsColors.colorsMap[AssetTypes.listedAssetOther]??Colors.brown;
          break;
        case 7:
          color = AssetsOverviewChartsColors.colorsMap[AssetTypes.otherAsset]??Colors.brown;
          break;
      }
      return LineChartBarData(
        isCurved: false,
        color: color,
        barWidth: 2,
        isStrokeCapRound: true,
        spots: List.generate(getChartEntities.length, (index) {
          GetChartEntity getChartEntity = getChartEntities[index];
          double y = 0;
          switch (mainIndex){
            case 0:
              y = getChartEntity.bankAccount;
              break;
            case 1:
              y = getChartEntity.privateEquity;
              break;
            case 2:
              y = getChartEntity.privateDebt;
              break;
            case 3:
              y = getChartEntity.realEstate;
              break;
            case 4:
              y = getChartEntity.listedAssetEquity;
              break;
            case 5:
              y = getChartEntity.listedAssetFixedIncome;
              break;
            case 6:
              y = getChartEntity.listedAssetOther;
              break;
            case 7:
              y = getChartEntity.others;
              break;
          }
          return FlSpot(index.toDouble(), y);
        }),
        belowBarData: BarAreaData(
          show: true,
          cutOffY: 0,
          applyCutOffY: true,
          color: color.withOpacity(0.7)
        ),
      );
    });
  }

  calculateMinMax(List<GetChartEntity> getChartEntities) {
    double minY = 0;
    double maxY = 0;
    if(getChartEntities.isNotEmpty){
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
        if(maxY2>maxY){
          maxY = maxY2;
        }
      }
    }
    return [minY,maxY];
  }
}
