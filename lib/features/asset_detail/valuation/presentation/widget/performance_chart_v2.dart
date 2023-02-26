import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    final x = maxY - minY / divider;
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
                    margin: const EdgeInsets.fromLTRB(10, 10, 15, 10),
                    plotAreaBorderWidth: 0,
                    // title: ChartTitle(text: 'title'),
                    primaryXAxis: CategoryAxis(
                      labelPlacement: LabelPlacement.onTicks,
                      majorGridLines: const MajorGridLines(width: 0),
                      labelStyle: textTheme.bodySmall,
                      edgeLabelPlacement: true
                          ? EdgeLabelPlacement.shift
                          : EdgeLabelPlacement.none,
                      labelIntersectAction: false
                          ? AxisLabelIntersectAction.rotate45
                          : AxisLabelIntersectAction.wrap,
                      crossesAt: 0,
                      placeLabelsNearAxisLine: false,
                    ),

                    primaryYAxis: CategoryAxis(
                        axisLine: const AxisLine(width: 0),
                        minimum: minY - x,
                        axisLabelFormatter: (axisLabelRenderArgs) =>
                            ChartAxisLabel(
                                axisLabelRenderArgs.value
                                    .formatNumberWithDecimal(),
                                textTheme.bodySmall),
                        maximum: maxY + x,
                        majorTickLines: const MajorTickLines(size: 1)),
                    series: _getSeries(),

                    tooltipBehavior: TooltipBehavior(
                        enable: true, header: '', canShowMarker: true),
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
          xValueMapper: (vs, _) => CustomizableDateTime.localizedDdMm(vs.key),
          yValueMapper: (vs, _) => vs.value,
          markerSettings: MarkerSettings(isVisible: values.length == 1)),
    ];
  }
}
