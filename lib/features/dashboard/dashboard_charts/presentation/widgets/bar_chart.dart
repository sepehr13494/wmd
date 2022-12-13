import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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
    const style = TextStyle(fontSize: 8);
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('Jan 2022', style: style);
        break;
      case 3:
        text = const Text('Feb 2022', style: style);
        break;
      case 5:
        text = const Text('Mar 2022', style: style);
        break;
      case 7:
        text = const Text('Apr 2022', style: style);
        break;
      case 9:
        text = const Text('Jun 2022', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          "\$ ${(value * 2.5)}M",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 10),
        ));
  }

  BarChartData mainData(context) {
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
      minY: -3,
      maxY: 6,
      barGroups: getData()
    );
  }

  List<BarChartGroupData> getData() {
    return [
      BarChartGroupData(
        x: 1,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            toY: 5,
            rodStackItems: [
              BarChartRodStackItem(0, 3, AppColors.chartColor),
              BarChartRodStackItem(3, 5, AppColors.redChartColor),
            ],
            borderRadius: BorderRadius.zero,
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            toY: 6,
            rodStackItems: [
              BarChartRodStackItem(0, 1.5, AppColors.chartColor),
              BarChartRodStackItem(1.5, 6, AppColors.redChartColor),
            ],
            borderRadius: BorderRadius.zero,
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            toY: 5,
            rodStackItems: [
              BarChartRodStackItem(0, 3, AppColors.chartColor),
              BarChartRodStackItem(3, 5, AppColors.redChartColor),
            ],
            borderRadius: BorderRadius.zero,
          ),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            toY: 4,
            rodStackItems: [
              BarChartRodStackItem(0, 2, AppColors.chartColor),
              BarChartRodStackItem(2, 4, AppColors.redChartColor),
            ],
            borderRadius: BorderRadius.zero,
          ),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            toY: 4,
            rodStackItems: [
              BarChartRodStackItem(0, 3, AppColors.chartColor),
              BarChartRodStackItem(3, 4, AppColors.redChartColor),
            ],
            borderRadius: BorderRadius.zero,
          ),
        ],
      ),
      BarChartGroupData(
        x: 6,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            toY: 5,
            rodStackItems: [
              BarChartRodStackItem(0, 1.5, AppColors.chartColor),
              BarChartRodStackItem(1.5, 5, AppColors.redChartColor),
            ],
            borderRadius: BorderRadius.zero,
          ),
        ],
      ),
      BarChartGroupData(
        x: 7,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            toY: 5,
            rodStackItems: [
              BarChartRodStackItem(0, 1.5, AppColors.chartColor),
              BarChartRodStackItem(1.5, 5, AppColors.redChartColor),
            ],
            borderRadius: BorderRadius.zero,
          ),
        ],
      ),
      BarChartGroupData(
        x: 8,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            toY: 5,
            rodStackItems: [
              BarChartRodStackItem(0, 1.5, AppColors.chartColor),
              BarChartRodStackItem(1.5, 5, AppColors.redChartColor),
            ],
            borderRadius: BorderRadius.zero,
          ),
        ],
      ),
      BarChartGroupData(
        x: 9,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            toY: 5,
            rodStackItems: [
              BarChartRodStackItem(0, 1.5, AppColors.chartColor),
              BarChartRodStackItem(1.5, 5, AppColors.redChartColor),
            ],
            borderRadius: BorderRadius.zero,
          ),
        ],
      ),
    ];
  }
}
