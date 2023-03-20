import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';
import 'performance_chart.dart';

class PerformanceLineChartV2 extends AppStatelessWidget {
  final List<MapEntry<DateTime, double>> values;
  final int days;
  const PerformanceLineChartV2(
      {super.key, required this.values, required this.days});

  @override
  Widget buildWidget(
      BuildContext context, textTheme, AppLocalizations appLocalizations) {
    TrackballBehavior trackBall = TrackballBehavior(
      enable: true,
      lineType: TrackballLineType.none,
      activationMode: ActivationMode.singleTap,
      builder: (context, TrackballDetails details) {
        final index = details.seriesIndex;
        if (index == null) {
          return const SizedBox();
        }
        final data = values.elementAt(index);

        return Card(
          color: const Color.fromARGB(255, 38, 49, 52),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  CustomizableDateTime.graphDateV2(data.key, context),
                  style: textTheme.titleSmall!,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(appLocalizations.assets_label_currentBalance,
                        style: textTheme.bodyMedium),
                    const SizedBox(width: 6),
                    PrivacyBlurWidget(
                      child: Text((data.value).formatCurrencyCompact(),
                          style: textTheme.titleSmall!
                              .apply(color: AppColors.chartColor)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      lineColor: AppColors.anotherCardColorForLightTheme,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              // ignore: prefer_interpolation_to_compose_strings
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
                      numberFormat: NumExt.getCompactNumberFormat(),
                      labelStyle: textTheme.bodySmall!.apply(fontSizeDelta: -3),
                      majorGridLines: const MajorGridLines(width: 1),
                    ),
                    series: _getSeries(),
                    // tooltipBehavior: tooltipBehavior,
                    trackballBehavior: trackBall,
                  );
                }),
        ),
      ],
    );
  }

  _getSeries() {
    final stops = calculateStops(values);
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
        // pointColorMapper: (datum, index) {
        //   if (datum.value > 0) return AppColors.chartColor;
        //   return AppColors.redChartColor;
        // },
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
            0,
            stops,
            stops,
            1,
          ],
          colors: [
            // AppColors.chartColor.withOpacity(0.3),
            AppColors.chartColor.withOpacity(0.5),
            AppColors.chartColor.withOpacity(0.3),
            AppColors.redChartColor.withOpacity(0.3),
            AppColors.redChartColor.withOpacity(0.5),
            // AppColors.redChartColor.withOpacity(0.3),
          ],
        ),

        markerSettings: MarkerSettings(
            isVisible: values.length == 1, color: AppColors.chartColor),
      ),
    ];
  }

  double calculateStops(List<MapEntry<DateTime, double>> values) {
    double minX = values.first.value;
    for (var element in values) {
      if (element.value < minX) {
        minX = element.value;
      }
    }
    if (minX > 0) {
      return 1;
    }
    double maxX = values.first.value;
    for (var element in values) {
      if (element.value > maxX) {
        minX = element.value;
      }
    }
    if (maxX < 0) {
      return 0;
    }
    double gradientStop = maxX / (maxX - minX);
    if (gradientStop > 1) {
      gradientStop = 1;
    } else if (gradientStop < 0) {
      gradientStop = 0;
    }
    return gradientStop;
  }
}
