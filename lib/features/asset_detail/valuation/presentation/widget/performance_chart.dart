import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/asset_detail/valuation/data/models/get_valuation_performance_params.dart';
import 'package:wmd/features/asset_detail/valuation/presentation/manager/performance_chart_cubit.dart';
import 'package:wmd/injection_container.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/util/colors.dart';

const _timeFilter = [
  // MapEntry<String, int>("All times", 0),
  MapEntry<String, int>("7 days", 7),
  MapEntry<String, int>("30 days", 30),
];

class PerformanceChart extends StatefulWidget {
  final String id;
  const PerformanceChart({super.key, required this.id});

  @override
  AppState<PerformanceChart> createState() => _PerformanceChartState();
}

class _PerformanceChartState extends AppState<PerformanceChart> {
  MapEntry<String, int> selectedTimeFilter = _timeFilter.first;

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final primarycolor = Theme.of(context).primaryColor;
    return BlocProvider(
      create: (context) => sl<PerformanceChartCubit>()
        ..getValuationPerformance(
            GetValuationPerformanceParams(days: 30, id: widget.id)),
      child: BlocConsumer<PerformanceChartCubit, PerformanceChartState>(
        listener: BlocHelper.defaultBlocListener(
          listener: (context, state) {},
        ),
        builder: (context, state) {
          if (state is PerformanceLoaded) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Performance chart',
                      style: textTheme.bodyLarge,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 15,
                          color: primarycolor,
                        ),
                        const SizedBox(width: 4),
                        DropdownButton<MapEntry<String, int>>(
                          items: _timeFilter
                              .map((e) =>
                                  DropdownMenuItem<MapEntry<String, int>>(
                                      value: e,
                                      child: Text(
                                        e.key,
                                        style: textTheme.bodyMedium!
                                            .apply(color: primarycolor),
                                        // textTheme.bodyMedium!.toLinkStyle(context),
                                      )))
                              .toList(),
                          onChanged: ((value) {
                            if (value != null) {
                              setState(() {
                                selectedTimeFilter = value;
                                context
                                    .read<PerformanceChartCubit>()
                                    .getValuationPerformance(
                                        GetValuationPerformanceParams(
                                            days: value.value, id: widget.id));
                              });
                            }
                          }),
                          value: selectedTimeFilter,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 15,
                            color: primarycolor,
                          ),
                          // style: textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                AspectRatio(
                  aspectRatio:
                      ResponsiveHelper(context: context).isMobile ? 1.6 : 2.2,
                  child: PerformanceLineChart(
                    values: state.getValuationPerformanceEntities
                        .map((e) => MapEntry(e.date, e.value))
                        .toList(),
                  ),
                ),
              ],
            );
          }
          return Padding(
            padding:
                EdgeInsets.all(ResponsiveHelper(context: context).bigger16Gap),
            child: const CircularProgressIndicator(),
          );
        },
      ),
    );
    ;
  }
}

class PerformanceLineChart extends StatelessWidget {
  final List<MapEntry<DateTime, double>> values;
  const PerformanceLineChart({super.key, required this.values});

  final double divider = 6;
  final double minDate = 6;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      mainData(context),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    late final Widget child;
    child = Text(
        CustomizableDateTime.localizedDdMm(values[(value).toInt()].key),
        style: const TextStyle(fontSize: 8));
    // if (values.length > minDate) {
    // } else {}
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

  LineChartData mainData(context) {
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
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
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
      // maxX: values.length > minDate ? null : minDate,
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
                      text: '\nCurrent Balance', style: textTheme.bodyMedium),
                  TextSpan(
                      // ignore: prefer_interpolation_to_compose_strings
                      text: '\n' +
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
          tooltipBgColor: Color.fromARGB(255, 38, 49, 52),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(values.length, (index) {
            return FlSpot((index).toDouble(), values[index].value / x);
          }),
          isCurved: false,
          color: AppColors.chartColor,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
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
