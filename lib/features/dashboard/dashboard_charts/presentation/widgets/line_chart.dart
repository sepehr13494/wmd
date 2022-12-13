import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/util/colors.dart';

import '../../domain/entities/get_allocation_entity.dart';

class LineChartSample2 extends StatelessWidget {
  final List<GetAllocationEntity> allocations;
  const LineChartSample2({super.key, required this.allocations});

  @override
  Widget build(BuildContext context) {
    return LineChart(
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
          "\$ ${(value * x)}",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 10),
        ),
    );
  }

  LineChartData mainData(context) {
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
    print(maxTotal);
    print(minY);
    print(maxY);
    double gradientStop =  maxY/(maxY - minY);
    if(gradientStop>1){
      gradientStop = 1;
    }else if(gradientStop<0){
      gradientStop = 0;
    }
    return LineChartData(
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
      maxX: allocations.length.toDouble()-1,
      minY: minY.abs() == maxTotal ? minY : minY >= 0 ? 0 : (- (minY.abs()).ceil().toDouble()),
      maxY: maxY.abs() == maxTotal ? maxY : maxY <= 0 ? 0 : (maxY.abs()).ceil().toDouble(),
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(allocations.length, (index) {
            return FlSpot(index.toDouble(), allocations[index].netWorth/x);
          }),
          isCurved: false,
          color: AppColors.chartColor,
          gradient: LinearGradient(
            colors: const [AppColors.chartColor,AppColors.chartColor, AppColors.errorColor,AppColors.errorColor],
            stops: [0,gradientStop,gradientStop,1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            cutOffY: 0,
            applyCutOffY: true,
            gradient: LinearGradient(
              colors: [
                AppColors.chartColor.withOpacity(0.3),
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          aboveBarData: BarAreaData(
            show: true,
            cutOffY: 0,
            applyCutOffY: true,
            gradient: LinearGradient(
              colors: [
                Colors.red.withOpacity(0.3),
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ],
    );
  }
}
