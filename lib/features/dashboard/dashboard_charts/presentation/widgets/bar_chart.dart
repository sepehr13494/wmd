import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/dashboard/dashboard_charts/domain/entities/get_allocation_entity.dart';

class BarChartMainDashboard extends StatelessWidget {
  final List<GetAllocationEntity> allocations;
  const BarChartMainDashboard({super.key, required this.allocations});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      mainData(context),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(allocations[value.toInt()].name, style: const TextStyle(fontSize: 8)),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    double minY = 0;
    if(allocations.isNotEmpty){
      minY = allocations[0].netWorth;
      for (var element in allocations) {
        if(element.netWorth<minY){
          minY = element.netWorth;
        }
      }
    }
    double maxY = 0;
    if(allocations.isNotEmpty){
      maxY = allocations[0].netWorth;
      for (var element in allocations) {
        if(element.netWorth>maxY){
          maxY = element.netWorth;
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
    if(allocations.isNotEmpty){
      minY = allocations[0].netWorth;
      for (var element in allocations) {
        if(element.netWorth<minY){
          minY = element.netWorth;
        }
      }
    }
    double maxY = 0;
    if(allocations.isNotEmpty){
      maxY = allocations[0].netWorth;
      for (var element in allocations) {
        if(element.netWorth>maxY){
          maxY = element.netWorth;
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
    return List.generate(allocations.length, (index) {
      return BarChartGroupData(
        x: index,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            toY: allocations[index].asset/x,
            rodStackItems: [
              BarChartRodStackItem(0, allocations[index].netWorth/x, AppColors.chartColor),
              BarChartRodStackItem(allocations[index].netWorth/x, allocations[index].asset/x, AppColors.redChartColor),
            ],
            borderRadius: BorderRadius.zero,
          ),
        ],
      );
    });
  }
}
