import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';
import 'package:wmd/features/dashboard/dashboard_charts/domain/entities/get_allocation_entity.dart';

import 'custom_dashboard_chart_tooltip.dart';

class PerformanceBarChart extends StatefulWidget {
  final List<GetAllocationEntity> allocations;

  const PerformanceBarChart({
    super.key,
    required this.allocations,
  });

  @override
  AppState<PerformanceBarChart> createState() => _PerformanceBarChartState();
}

class _PerformanceBarChartState extends AppState<PerformanceBarChart> {
  final double divider = 6;
  late final List<MapEntry<DateTime, double>> values;
  final double minDate = 6;

  Timer? _timer;
  bool showTooltip = false;
  GetAllocationEntity? selected;
  double position = 0;

  @override
  void initState() {
    super.initState();
    values = widget.allocations.map((e) {
      var dateString = e.name.split(" ")[0].split("/");
      DateTime dateTime = DateTime(int.parse(dateString[2]),
          int.parse(dateString[0]), int.parse(dateString[1]));
      return MapEntry(dateTime, e.asset);
    }).toList();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return AspectRatio(
      aspectRatio: ResponsiveHelper(context: context).isMobile ? 1.6 : 2.2,
      child: values.isEmpty
          ? const EmptyChartWidget()
          : Builder(builder: (context) {
              if (values.length == 1) {
                return Row(
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
                            mainData(context, appLocalizations,
                                showLeft: false),
                          ),
                        ],
                      ),
                    )
                  ],
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
            }),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta, bool hideValues) {
    late final Widget child;
    if (hideValues) {
      child = const SizedBox.shrink();
    } else {
      int x = (widget.allocations.length / 7).ceil();
      var dateString =
          widget.allocations[value.toInt()].name.split(" ")[0].split("/");
      DateTime dateTime = DateTime(int.parse(dateString[2]),
          int.parse(dateString[0]), int.parse(dateString[1]));
      child = value.toInt() % x == 0
          ? SideTitleWidget(
              axisSide: meta.axisSide,
              child: Text(
                  CustomizableDateTime.miniDate(
                      widget.allocations[value.toInt()].name),
                  style: const TextStyle(fontSize: 8)),
            )
          : const SizedBox();
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
    double x = maxY / divider;

    final String shown =
        value == 0 ? "\$0" : (value * x).formatNumberWithDecimal();
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: PrivacyBlurWidget(
          child: Text(
            shown,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 10),
          ),
        ),
      ),
    );
  }

  LineChartData mainData(context, AppLocalizations appLocalizations,
      {bool showLeft = true, bool hideValues = false}) {
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
    double x = maxY / divider;

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
      lineBarsData: [
        LineChartBarData(
          spots: hideValues
              ? []
              : List.generate(values.length, (index) {
                  return FlSpot((index).toDouble(), values[index].value / x);
                }),
          isCurved: false,
          color: AppColors.primary,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (p0, p1, p2, p3) {
              return FlDotCirclePainter(
                radius: 2,
                color: AppColors.primary,
                strokeColor: AppColors.primaryDarker,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            cutOffY: 0,
            applyCutOffY: true,
            spotsLine: BarAreaSpotsLine(
                show: true,
                flLineStyle: FlLine(
                    color: AppColors.chartColor,
                    strokeWidth: widget.allocations.length > 10 ? 5 : 15)),
            color: Colors.transparent,
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
