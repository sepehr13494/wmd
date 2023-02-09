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
  final List<String> titles;
  const AssetsOverviewAreaChart({super.key, required this.getChartEntities, required this.titles});

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
              final appLocalizations = AppLocalizations.of(context);
              return List.generate(touchedSpots.length, (index) {
                return LineTooltipItem(
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
                );
              });
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
    return List.generate(titles.length, (mainIndex) {
      Color color = Colors.transparent;
      switch (titles[mainIndex]){
        case AssetTypes.bankAccount:
          color = AssetsOverviewChartsColors.colorsMap[AssetTypes.bankAccount]??Colors.brown;
          break;
        case AssetTypes.privateEquity:
          color = AssetsOverviewChartsColors.colorsMap[AssetTypes.privateEquity]??Colors.brown;
          break;
        case AssetTypes.privateDebt:
          color = AssetsOverviewChartsColors.colorsMap[AssetTypes.privateDebt]??Colors.brown;
          break;
        case AssetTypes.realEstate:
          color =AssetsOverviewChartsColors.colorsMap[AssetTypes.realEstate]??Colors.brown;
          break;
        case AssetTypes.listedAssetEquity:
          color = AssetsOverviewChartsColors.colorsMap[AssetTypes.listedAssetEquity]??Colors.brown;
          break;
        case AssetTypes.listedAssetFixedIncome:
          color = AssetsOverviewChartsColors.colorsMap[AssetTypes.listedAssetFixedIncome]??Colors.brown;
          break;
        case AssetTypes.listedAssetOther:
          color = AssetsOverviewChartsColors.colorsMap[AssetTypes.listedAssetOther]??Colors.brown;
          break;
        case AssetTypes.otherAsset:
          color = AssetsOverviewChartsColors.colorsMap[AssetTypes.otherAsset]??Colors.brown;
          break;
      }
      return LineChartBarData(
        isCurved: false,
        color: color,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        spots: List.generate(getChartEntities.length, (index) {
          GetChartEntity getChartEntity = getChartEntities[index];
          double y = 0;
          switch (titles[mainIndex]){
            case AssetTypes.bankAccount:
              y = getChartEntity.bankAccount/x;
              break;
            case AssetTypes.privateEquity:
              y = getChartEntity.privateEquity/x;
              break;
            case AssetTypes.privateDebt:
              y = getChartEntity.privateDebt/x;
              break;
            case AssetTypes.realEstate:
              y = getChartEntity.realEstate/x;
              break;
            case AssetTypes.listedAssetEquity:
              y = getChartEntity.listedAssetEquity/x;
              break;
            case AssetTypes.listedAssetFixedIncome:
              y = getChartEntity.listedAssetFixedIncome/x;
              break;
            case AssetTypes.listedAssetOther:
              y = getChartEntity.listedAssetOther/x;
              break;
            case AssetTypes.otherAsset:
              y = getChartEntity.others/x;
              break;
          }
          return FlSpot(index.toDouble(), y);
        }),
        belowBarData: BarAreaData(
          show: true,
          cutOffY: 0,
          applyCutOffY: true,
          color: color.withOpacity(0.4)
        ),
      );
    });
  }

  calculateMinMax(List<GetChartEntity> getChartEntities) {
    double minY = 0;
    double maxY = 0;
    if(getChartEntities.isNotEmpty){
      for (var element in getChartEntities) {
        if(element.bankAccount > maxY){
          maxY += element.bankAccount;
        }
        if(element.listedAssetEquity > maxY){
          maxY += element.listedAssetEquity;
        }
        if(element.listedAssetFixedIncome > maxY){
          maxY += element.listedAssetFixedIncome;
        }
        if(element.listedAssetOther > maxY){
          maxY += element.listedAssetOther;
        }
        if(element.others > maxY){
          maxY += element.others;
        }
        if(element.privateDebt > maxY){
          maxY += element.privateDebt;
        }
        if(element.realEstate > maxY){
          maxY += element.realEstate;
        }
        if(element.privateEquity > maxY){
          maxY += element.privateEquity;
        }
      }
    }
    return [minY,maxY];
  }
}
