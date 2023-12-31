import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/custom_dashboard_chart_tooltip.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/min_max_calculator.dart';
import '../../domain/entities/get_allocation_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LineChartSample2 extends StatefulWidget {
  final List<GetAllocationEntity> allocations;
  const LineChartSample2({super.key, required this.allocations});

  @override
  AppState<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends AppState<LineChartSample2> {
  Timer? _timer;
  bool showTooltip = false;
  GetAllocationEntity? selected;
  double position = 0;

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    if (widget.allocations.length == 1) {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            Expanded(
              child: LineChart(
                mainData(context, appLocalizations, hideValues: true),
              ),
            ),
            Expanded(
              child: Stack(
                alignment: const Alignment(-1, 0),
                children: [
                  LineChart(
                    mainData(context, appLocalizations, showLeft: false),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
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
            mainData(context, appLocalizations),
          ),
          showTooltip
              ? CustomDashboardChartTooltip(selected: selected)
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

  Widget bottomTitleWidgets(double value, TitleMeta meta, bool hideValues) {
    int x = (widget.allocations.length / 7).ceil();
    var dateString =
        widget.allocations[value.toInt()].name.split(" ")[0].split("/");
    DateTime dateTime = DateTime(int.parse(dateString[2]),
        int.parse(dateString[0]), int.parse(dateString[1]));
    if (hideValues) {
      return SizedBox();
    } else {
      return value.toInt() % x == 0
          ? SideTitleWidget(
              axisSide: meta.axisSide,
              child: Text(
                  CustomizableDateTime.miniDate(
                      widget.allocations[value.toInt()].name),
                  style: const TextStyle(fontSize: 8)),
            )
          : const SizedBox();
    }
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    List<double> minMax =
        MinMaxCalculator.calculateMinyMaxY(widget.allocations);
    final double minY = minMax[0];
    final double maxY = minMax[1];
    double x = max(maxY.abs(), minY.abs()) / 5;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: PrivacyBlurWidget(
          child: Text(
            (value * x).formatNumberWithDecimal(),
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 10),
          ),
        ),
      ),
    );
  }

  LineChartData mainData(context, AppLocalizations appLocalizations,
      {bool showLeft = true, bool hideValues = false}) {
    List<double> minMax =
        MinMaxCalculator.calculateMinyMaxY(widget.allocations);
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
      lineTouchData: LineTouchData(
          touchCallback: (p0, p1) {
            if (p1 != null) {
              if (p1.lineBarSpots != null) {
                setState(() {
                  selected =
                      widget.allocations[p1.lineBarSpots!.first.spotIndex];
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
              getTooltipItems: (touchedSpots) {
                return [LineTooltipItem("", const TextStyle())];
              },
              tooltipPadding: const EdgeInsets.all(0.5))),
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
            getTitlesWidget: (value, meta) =>
                bottomTitleWidgets(value, meta, hideValues),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: showLeft,
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
          spots: hideValues
              ? []
              : List.generate(widget.allocations.length, (index) {
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
            show: widget.allocations.length == 1,
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

  _textSpans(int x, textTheme, bool showDate, appLocalizations) {
    return [
      showDate
          ? TextSpan(
              text: CustomizableDateTime.miniDateOneLine(
                  widget.allocations[x].name),
            )
          : const TextSpan(),
      TextSpan(
          // ignore: prefer_interpolation_to_compose_strings
          text: '\n\n' +
              appLocalizations.home_dashboardCharts_legendLabel_netWorth +
              "    ",
          style: textTheme.titleSmall),
      TextSpan(
          // ignore: prefer_interpolation_to_compose_strings
          text: widget.allocations[x].netWorth.formatNumberWithDecimal(),
          style: textTheme.titleSmall!.apply(color: AppColors.chartColor)),
      TextSpan(
          // ignore: prefer_interpolation_to_compose_strings
          text: '\n' +
              appLocalizations.home_dashboardCharts_legendLabel_assets +
              "         ",
          style: textTheme.titleSmall),
      TextSpan(
          // ignore: prefer_interpolation_to_compose_strings
          text: widget.allocations[x].asset.formatNumberWithDecimal(),
          style: textTheme.titleSmall!.apply(color: AppColors.chartColor)),
      TextSpan(
          // ignore: prefer_interpolation_to_compose_strings
          text: '\n' +
              appLocalizations.home_dashboardCharts_legendLabel_liability +
              "      ",
          style: textTheme.titleSmall),
      TextSpan(
          // ignore: prefer_interpolation_to_compose_strings
          text: widget.allocations[x].liability.formatNumberWithDecimal(),
          style: textTheme.titleSmall!.apply(color: AppColors.chartColor)),
    ];
  }
}
