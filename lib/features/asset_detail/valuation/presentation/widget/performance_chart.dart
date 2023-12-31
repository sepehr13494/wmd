import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@Deprecated('Use V2')
class PerformanceLineChart extends AppStatelessWidget {
  final List<MapEntry<DateTime, double>> values;
  final int days;
  const PerformanceLineChart(
      {super.key, required this.values, required this.days});

  final double divider = 6;
  final double minDate = 6;

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    debugPrint("values.toString()");
    debugPrint("values.toString()");
    debugPrint("values.toString()");
    debugPrint(values.toString());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              appLocalizations.assets_label_performanceChart,
              style: textTheme.bodyLarge,
            ),
            const SizedBox(width: 8),
            Text(
              '(${appLocalizations.assets_label_lastDurationDays.replaceFirstMapped('{{duration}}', (match) => days.toString())})',
              // '(Last $days days)',
              style: textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 24),
        AspectRatio(
          aspectRatio: ResponsiveHelper(context: context).isMobile ? 1.6 : 2.2,
          child: values.isEmpty
              ? const EmptyChartWidget()
              : Builder(builder: (context) {
                  if (values.length == 1) {
                    return Row(
                      children: [
                        Expanded(
                          child: LineChart(
                            mainData(context, appLocalizations,
                                hideValues: true),
                          ),
                        ),
                        Expanded(
                          child: LineChart(
                            mainData(context, appLocalizations,
                                showLeft: false),
                          ),
                        )
                      ],
                    );
                  }
                  return LineChart(
                    mainData(context, appLocalizations),
                  );
                }),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta, bool hideValues) {
    late final Widget child;
    if (hideValues) {
      child = const SizedBox.shrink();
    } else {
      child = FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
            CustomizableDateTime.localizedDdMm(values[(value).toInt()].key),
            style: const TextStyle(fontSize: 8)),
      );
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: child,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    double minY = 0;
    if (values.isNotEmpty) {
      minY = values[0].value;
      for (var element in values) {
        if (element.value < minY) {
          minY = element.value;
        }
      }
    }
    double maxY = 0;
    if (values.isNotEmpty) {
      maxY = values[0].value;
      for (var element in values) {
        if (element.value > maxY) {
          maxY = element.value;
        }
      }
    }
    double x = maxY * 2 / divider;

    final String shown =
        value == 0 ? "\$0" : (value * x).formatNumberWithDecimal();
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        shown,
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 10),
      ),
    );
  }

  LineChartData mainData(context, AppLocalizations appLocalizations,
      {bool showLeft = true, bool hideValues = false}) {
    debugPrint("values.toString()");
    debugPrint("mainData.toString()");
    debugPrint("mainData.toString()");
    debugPrint(values.toString());

    double minY = 0;
    if (values.isNotEmpty) {
      minY = values[0].value;
      for (var element in values) {
        if (element.value < minY) {
          minY = element.value;
        }
      }
    }
    double maxY = 0;
    if (values.isNotEmpty) {
      maxY = values[0].value;
      for (var element in values) {
        if (element.value > maxY) {
          maxY = element.value;
        }
      }
    }
    double x = maxY * 2 / divider;

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
            interval: 1,
            reservedSize: 30,
            getTitlesWidget: (value, meta) =>
                bottomTitleWidgets(value, meta, hideValues),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: showLeft,
            interval: 1,
            reservedSize: 42,
            getTitlesWidget: leftTitleWidgets,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border.symmetric(
              horizontal: BorderSide(
                  width: 0.3, color: AppColors.dashBoardGreyTextColor))),
      minY: 0,
      maxY: divider,
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          fitInsideVertically: true,
          fitInsideHorizontally: true,
          getTooltipItems: (touchedSpots) {
            final textTheme = Theme.of(context).textTheme;
            return [
              LineTooltipItem(
                CustomizableDateTime.localizedDdMmYyyy(
                    values[touchedSpots.first.x.toInt()].key),
                textTheme.titleSmall!,
                textAlign: TextAlign.start,
                children: [
                  TextSpan(
                      text: '\n${appLocalizations.assets_label_currentBalance}',
                      style: textTheme.bodyMedium),
                  TextSpan(
                      // ignore: prefer_interpolation_to_compose_strings
                      text: ' ' +
                          values[touchedSpots.first.x.toInt()]
                              .value
                              .formatNumberWithDecimal(),
                      style: textTheme.titleSmall!
                          .apply(color: AppColors.chartColor)),
                ],
              )
            ];
          },
          maxContentWidth: 200,
          tooltipBgColor: AppColors.blueCardColor,
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: hideValues
              ? []
              : List.generate(values.length, (index) {
                  return FlSpot((index).toDouble(), values[index].value / x);
                }),
          isCurved: false,
          color: AppColors.chartColor,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: values.length == 1,
          ),
          belowBarData: BarAreaData(
            show: true,
            cutOffY: 0,
            applyCutOffY: true,
            color: AppColors.chartColor.withOpacity(0.3),
          ),
        ),
      ],
    );
  }
}

class EmptyChartWidget extends AppStatelessWidget {
  const EmptyChartWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Container(
      color: Theme.of(context).cardColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.info),
          const SizedBox(height: 4),
          Text(appLocalizations.common_errors_somethingWentWrong),
          const SizedBox(height: 4),
          Text(
            appLocalizations.common_dashboardErrorStateWidget_description,
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
