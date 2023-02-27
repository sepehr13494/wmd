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
import 'dart:ui' as ui;
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
      builder: (data, point, series, pointIndex, seriesIndex) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text.rich(TextSpan(
            text: CustomizableDateTime.localizedDdMmYyyy(data.key as DateTime),
            style: textTheme.titleSmall!,
            children: [
              TextSpan(
                  text: '\n${appLocalizations.assets_label_currentBalance}',
                  style: textTheme.bodyMedium),
              TextSpan(
                  // ignore: prefer_interpolation_to_compose_strings
                  text: ' ${(data.value as double).formatCurrencyCompact()}',
                  style:
                      textTheme.titleSmall!.apply(color: AppColors.chartColor)),
            ],
          )),
        );
      },
      color: const Color.fromARGB(255, 38, 49, 52),
    );

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
                      crossesAt: 0,
                      placeLabelsNearAxisLine: false,
                    ),
                    primaryYAxis: NumericAxis(
                      numberFormat: NumberFormat.compactCurrency(symbol: '\$'),
                      labelStyle: textTheme.bodySmall!.apply(fontSizeDelta: -3),
                      majorGridLines: const MajorGridLines(width: 1),
                    ),
                    series: _getSeries(),
                    tooltipBehavior: tooltipBehavior,
                  );
                }),
        ),
      ],
    );
  }

  _getSeries() {
    return [
      AreaSeries<MapEntry<DateTime, double>, String>(
        // color: AppColors.chartColor.withOpacity(0.3),
        borderColor: AppColors.chartColor,

        borderWidth: 2,
        dataSource: values,
        animationDuration: 2500,
        enableTooltip: true,
        xValueMapper: (vs, _) => CustomizableDateTime.localizedDdMm(vs.key),
        yValueMapper: (vs, _) => vs.value,
        pointColorMapper: (datum, index) {
          if (datum.value > 0) return AppColors.chartColor;
          return AppColors.redChartColor;
        },
        gradient: LinearGradient(
          colors: <Color>[
            AppColors.chartColor.withOpacity(0.3),
            AppColors.redChartColor.withOpacity(0.3),
          ],
          stops: <double>[0.1, 0.3, 0.5, 0.7, 0.9],
          // Setting alignment for the series gradient
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        // onCreateRenderer: (series) {
        //   return _CustomAreaSeriesRenderer(series);
        // },
        markerSettings: MarkerSettings(
            isVisible: values.length == 1, color: AppColors.chartColor),
      ),
    ];
  }
}

// class _CustomAreaSeriesRenderer extends AreaSeriesRenderer {
//   _CustomAreaSeriesRenderer(this.series);

//   final ChartSeries<MapEntry<DateTime, double>, String> series;

//   @override
//   AreaSegment createSegment() => _AreaCustomPainter(series);
// }

// class _AreaCustomPainter extends AreaSegment {
//   _AreaCustomPainter(this.series);

//   final ChartSeries<MapEntry<DateTime, double>, String> series;
//   @override
//   int get currentSegmentIndex => super.currentSegmentIndex!;

//   @override
//   Paint getFillPaint() {
//     final Paint customerFillPaint = Paint();
//     log('Mert log:   $currentSegmentIndex');
//     customerFillPaint.color = series.dataSource![currentSegmentIndex].value > 0
//         ? AppColors.chartColor.withOpacity(0.3)
//         : AppColors.redChartColor.withOpacity(0.3);
//     customerFillPaint.style = PaintingStyle.fill;
//     return customerFillPaint;
//   }
// }
