import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/assets_overview/charts/domain/entities/get_chart_entity.dart';

import 'constants.dart';

class AssetsOverviewCharts extends StatelessWidget {
  final List<GetChartEntity> getChartEntities;
  const AssetsOverviewCharts({super.key, required this.getChartEntities});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      mainData(context),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(getChartEntities[value.toInt()].date, style: const TextStyle(fontSize: 8)),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    double minY = 0;
    double maxY = 0;
    if(getChartEntities.isNotEmpty){
      maxY += getChartEntities[0].bankAccount;
      maxY += getChartEntities[0].listedAsset;
      maxY += getChartEntities[0].others;
      maxY += getChartEntities[0].privateDebt;
      maxY += getChartEntities[0].realEstate;
      maxY += getChartEntities[0].privateEquity;
      for (var element in getChartEntities) {
        double maxY2 = 0;
        maxY2 += element.bankAccount;
        maxY2 += element.listedAsset;
        maxY2 += element.others;
        maxY2 += element.privateDebt;
        maxY2 += element.realEstate;
        maxY2 += element.privateEquity;
        if(maxY2>maxY){
          maxY = maxY2;
        }
      }
    }
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

  BarChartData mainData(context) {
    double minY = 0;
    double maxY = 0;
    if(getChartEntities.isNotEmpty){
      maxY += getChartEntities[0].bankAccount;
      maxY += getChartEntities[0].listedAsset;
      maxY += getChartEntities[0].others;
      maxY += getChartEntities[0].privateDebt;
      maxY += getChartEntities[0].realEstate;
      maxY += getChartEntities[0].privateEquity;
      for (var element in getChartEntities) {
        double maxY2 = 0;
        maxY2 += element.bankAccount;
        maxY2 += element.listedAsset;
        maxY2 += element.others;
        maxY2 += element.privateDebt;
        maxY2 += element.realEstate;
        maxY2 += element.privateEquity;
        if(maxY2>maxY){
          maxY = maxY2;
        }
      }
    }
    double x = max(maxY.abs() , minY.abs()) / 5;
    minY = (minY/x);
    maxY = (maxY/x);
    double maxTotal = max(minY.abs(), maxY.abs());
    return BarChartData(
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
        minY: minY.abs() == maxTotal ? minY : minY >= 0 ? 0 : (- (minY.abs()).ceil().toDouble()),
        maxY: maxY.abs() == maxTotal ? maxY : maxY <= 0 ? 0 : (maxY.abs()).ceil().toDouble(),
        barGroups: getData(x)
    );
  }

  List<BarChartGroupData> getData(double x) {
    return List.generate(getChartEntities.length, (index) {
      GetChartEntity getChartEntity = getChartEntities[index];
      final double sum =
          getChartEntity.privateEquity+
          getChartEntity.realEstate+
          getChartEntity.privateDebt+
          getChartEntity.others+
          getChartEntity.bankAccount+
          getChartEntity.listedAsset;
      final bankList = getChartEntity.bankAccount/x + getChartEntity.listedAsset/x;
      final bankListEquity = bankList + getChartEntity.privateEquity/x;
      final bankListEquityDept = bankListEquity + getChartEntity.privateDebt/x;
      final bankListEquityDeptEstate = bankListEquityDept + getChartEntity.realEstate/x;
      return BarChartGroupData(
        x: index,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            toY: sum/x,
            rodStackItems: [
              BarChartRodStackItem(0, getChartEntity.bankAccount/x, AssetsOverviewChartsColors.colors[0]),
              BarChartRodStackItem(getChartEntity.bankAccount/x, bankList, AssetsOverviewChartsColors.colors[1]),
              BarChartRodStackItem(bankList, bankListEquity, AssetsOverviewChartsColors.colors[2]),
              BarChartRodStackItem(bankListEquity, bankListEquityDept, AssetsOverviewChartsColors.colors[3]),
              BarChartRodStackItem(bankListEquityDept, bankListEquityDeptEstate, AssetsOverviewChartsColors.colors[4]),
              BarChartRodStackItem(bankListEquityDeptEstate, sum/x, AssetsOverviewChartsColors.colors[5]),
            ],
            borderRadius: BorderRadius.zero,
          ),
        ],
      );
    });
  }
}
