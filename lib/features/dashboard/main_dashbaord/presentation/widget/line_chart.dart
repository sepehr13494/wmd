import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/util/colors.dart';

class LineChartSample2 extends StatelessWidget {
  const LineChartSample2({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text("Total Net Worth",style: TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            AspectRatio(
              aspectRatio: 1.5,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: LineChart(
                  mainData(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
        fontSize: 8
    );
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

  LineChartData mainData(context) {
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
          border: const Border.symmetric(horizontal: BorderSide(width: 0.3,color: AppColors.dashBoardGreyTextColor))
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: false,
          color: AppColors.chartColor,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                AppColors.chartColor.withOpacity(0.3),
                Colors.white.withOpacity(0.0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}

