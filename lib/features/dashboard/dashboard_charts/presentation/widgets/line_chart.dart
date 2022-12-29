import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/min_max_calculator.dart';

import '../../domain/entities/get_allocation_entity.dart';

class LineChartSample2 extends StatefulWidget {
  final List<GetAllocationEntity> allocations;
  const LineChartSample2({super.key, required this.allocations});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  bool isOneData = false;

  @override
  void initState() {
    if (widget.allocations.length == 1) {
      isOneData = true;
      widget.allocations.add(widget.allocations.first);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      mainData(context),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(widget.allocations[value.toInt()].name,
          style: const TextStyle(fontSize: 8)),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    List<double> minMax =
        MinMaxCalculator.calculateMinyMaxY(widget.allocations, isOneData);
    final double minY = minMax[0];
    final double maxY = minMax[1];
    double x = max(maxY.abs(), minY.abs()) / 5;
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
    List<double> minMax =
        MinMaxCalculator.calculateMinyMaxY(widget.allocations, isOneData);
    double minY = minMax[0];
    double maxY = minMax[1];
    double x = max(maxY.abs(), minY.abs()) / 5;
    minY = (minY / x);
    maxY = (maxY / x);
    double maxTotal = max(minY.abs(), maxY.abs());
    double gradientStop = maxY / (maxY - minY);
    if (gradientStop > 1) {
      gradientStop = 1;
    } else if (gradientStop < 0) {
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
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          fitInsideVertically: true,
          fitInsideHorizontally: true,
          getTooltipItems: (touchedSpots) {
            final textTheme = Theme.of(context).textTheme;
            return [
              LineTooltipItem(
                widget.allocations[touchedSpots.first.x.toInt()].name,
                textTheme.titleSmall!,
                textAlign: TextAlign.start,
                children: [
                  TextSpan(
                      text: '\nCurrent Balance', style: textTheme.bodyMedium),
                  TextSpan(
                      // ignore: prefer_interpolation_to_compose_strings
                      text: '\n' +
                          widget.allocations[touchedSpots.first.x.toInt()]
                              .netWorth
                              .formatNumberWithDecimal(),
                      style: textTheme.titleSmall!
                          .apply(color: AppColors.chartColor)),
                ],
              )
            ];
          },
          maxContentWidth: 200,
          tooltipBgColor: const Color.fromARGB(255, 38, 49, 52),
        ),
      ),
      minX: 0,
      maxX: widget.allocations.length.toDouble() - 1,
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
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(widget.allocations.length, (index) {
            return FlSpot(
                index.toDouble(), widget.allocations[index].netWorth / x);
          }),
          isCurved: false,
          color: AppColors.chartColor,
          gradient: LinearGradient(colors: [
            AppColors.chartColor,
            AppColors.chartColor,
            minY == 0 ? AppColors.chartColor : AppColors.errorColor,
            minY == 0 ? AppColors.chartColor : AppColors.errorColor
          ], stops: [
            0,
            gradientStop,
            gradientStop,
            1
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
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
