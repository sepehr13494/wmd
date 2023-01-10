import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/dashboard/dashboard_charts/domain/entities/get_allocation_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'min_max_calculator.dart';

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
    int x = (allocations.length/7).ceil();
    return value.toInt() % x == 0 ? SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
          CustomizableDateTime.miniDate(allocations[value.toInt()].name),
          style: const TextStyle(fontSize: 8)),
    ) : const SizedBox();
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    List<double> minMax = MinMaxCalculator.calculateMinyMaxY(allocations,false);
    double minY = minMax[0];
    double maxY = minMax[1];
    print(minY);
    print(maxY);
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
    List<double> minMax = MinMaxCalculator.calculateMinyMaxY(allocations,false);
    double minY = minMax[0];
    double maxY = minMax[1];
    double x = max(maxY.abs() , minY.abs()) / 5;
    minY = (minY/x);
    maxY = (maxY/x);
    double maxTotal = max(minY.abs(), maxY.abs());
    return BarChartData(
      barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            fitInsideVertically: true,
            fitInsideHorizontally: true,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final textTheme = Theme.of(context).textTheme;
              return BarTooltipItem(
                  CustomizableDateTime.miniDateOneLine(allocations[groupIndex.toInt()].name),
                textTheme.titleSmall!,
                textAlign: TextAlign.start,
                children: [
                  TextSpan(
                    // ignore: prefer_interpolation_to_compose_strings
                      text: '\n\n' +
                          AppLocalizations.of(context).home_dashboardCharts_legendLabel_netWorth+ "    ",
                      style: textTheme.titleSmall),
                  TextSpan(
                    // ignore: prefer_interpolation_to_compose_strings
                      text: allocations[groupIndex.toInt()]
                          .netWorth
                          .formatNumberWithDecimal(),
                      style: textTheme.titleSmall!
                          .apply(color: AppColors.chartColor)),
                  TextSpan(
                    // ignore: prefer_interpolation_to_compose_strings
                      text: '\n' +
                          AppLocalizations.of(context).home_dashboardCharts_legendLabel_assets+ "         ",
                      style: textTheme.titleSmall),
                  TextSpan(
                    // ignore: prefer_interpolation_to_compose_strings
                      text: allocations[groupIndex.toInt()]
                          .asset
                          .formatNumberWithDecimal(),
                      style: textTheme.titleSmall!
                          .apply(color: AppColors.chartColor)),
                  TextSpan(
                    // ignore: prefer_interpolation_to_compose_strings
                      text: '\n' + AppLocalizations.of(context).home_dashboardCharts_legendLabel_liability+ "      ",
                      style: textTheme.titleSmall),
                  TextSpan(
                    // ignore: prefer_interpolation_to_compose_strings
                      text: allocations[groupIndex.toInt()]
                          .liability
                          .formatNumberWithDecimal(),
                      style: textTheme.titleSmall!
                          .apply(color: AppColors.chartColor)),
                ],
              );
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
