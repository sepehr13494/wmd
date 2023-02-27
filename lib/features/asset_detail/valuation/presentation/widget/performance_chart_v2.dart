import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';

import 'performance_chart.dart';

class PerformanceLineChartV2 extends AppStatelessWidget {
  final List<MapEntry<DateTime, double>> values;
  final int days;
  const PerformanceLineChartV2(
      {super.key, required this.values, required this.days});

  @override
  Widget buildWidget(
      BuildContext context, textTheme, AppLocalizations appLocalizations) {
    const int divider = 6;
    TooltipBehavior tooltipBehavior = TooltipBehavior(
        enable: true,
        // borderColor: Colors.red,
        // borderWidth: 5,
        builder: (data, point, series, pointIndex, seriesIndex) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text.rich(TextSpan(
              text:
                  CustomizableDateTime.localizedDdMmYyyy(data.key as DateTime),
              style: textTheme.titleSmall!,
              children: [
                TextSpan(
                    text: '\n${appLocalizations.assets_label_currentBalance}',
                    style: textTheme.bodyMedium),
                TextSpan(
                    // ignore: prefer_interpolation_to_compose_strings
                    text:
                        ' ${(data.value as double).formatNumberWithDecimal()}',
                    style: textTheme.titleSmall!
                        .apply(color: AppColors.chartColor)),
              ],
            )),
          );
        },
        color: const Color.fromARGB(255, 38, 49, 52));
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
    late final double x;
    if (maxY - minY == 0) {
      if (maxY > 0) {
        x = maxY;
      } else {
        x = -maxY;
      }
    } else {
      x = maxY - minY / divider;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              // ignore: prefer_interpolation_to_compose_strings
              appLocalizations.assets_label_performanceChart + ' V2',
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
                  return SfCartesianChart(
                    margin: const EdgeInsets.all(0),
                    plotAreaBorderWidth: 0,
                    primaryXAxis: CategoryAxis(
                      labelPlacement: LabelPlacement.onTicks,
                      majorGridLines: const MajorGridLines(width: 1),
                      labelStyle: textTheme.bodySmall!.apply(fontSizeDelta: -3),
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      labelIntersectAction: AxisLabelIntersectAction.wrap,
                      crossesAt: maxY > 0 ? 0 : null,
                      placeLabelsNearAxisLine: false,
                    ),
                    primaryYAxis: NumericAxis(
                      numberFormat: NumberFormat.compactCurrency(symbol: '\$'),
                      labelStyle: textTheme.bodySmall!.apply(fontSizeDelta: -3),
                      majorGridLines: const MajorGridLines(width: 1),
                    ),
                    // primaryYAxis: CategoryAxis(
                    //   labelStyle: textTheme.bodySmall,
                    //   axisLine: const AxisLine(width: 0),
                    //   axisLabelFormatter: (axisLabelRenderArgs) {
                    //     log('Mertlog:  ${axisLabelRenderArgs.value}');
                    //     return ChartAxisLabel(
                    //         axisLabelRenderArgs.value.formatNumberWithDecimal(),
                    //         textTheme.bodySmall);
                    //   },
                    //   minimum: minY - x,
                    //   maximum: maxY + x,
                    //   // majorTickLines: const MajorTickLines(size: 1),
                    //   majorGridLines: const MajorGridLines(width: 1),
                    // ),
                    series: _getSeries(),
                    tooltipBehavior: tooltipBehavior,
                    // tooltipBehavior: TooltipBehavior(
                    //   enable: true,
                    //   header: 'bksjdhfgkljshdfgljkshd',
                    //   canShowMarker: true,
                    // ),
                  );
                }),
        ),
      ],
    );
  }

  _getSeries() {
    return [
      AreaSeries<MapEntry<DateTime, double>, String>(
        color: AppColors.chartColor.withOpacity(0.3),
        borderColor: AppColors.chartColor,
        borderWidth: 2,
        dataSource: values,
        animationDuration: 2500,
        enableTooltip: true,
        xValueMapper: (vs, _) => CustomizableDateTime.localizedDdMm(vs.key),
        yValueMapper: (vs, _) => vs.value,
        markerSettings: MarkerSettings(
            isVisible: values.length == 1, color: AppColors.chartColor),
      ),
    ];
  }
}
