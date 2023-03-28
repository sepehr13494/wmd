import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/empty_chart.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_allocation_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/line_chart.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/shimmer/networth_chart_shimmer.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/performance_bar_chart.dart';
import '../manager/dashboard_charts_cubit.dart';

class NetWorthBaseChart extends StatefulWidget {
  const NetWorthBaseChart({Key? key}) : super(key: key);

  @override
  AppState<NetWorthBaseChart> createState() => _NetWorthBaseChartState();
}

class _NetWorthBaseChartState extends AppState<NetWorthBaseChart> {
  bool barChart = false;

  // final charts = ['bar', 'area'];

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final charts = {
      'bar': appLocalizations.assets_charts_allocationCharts_barChartLabel,
      'area': appLocalizations.assets_charts_allocationCharts_areaChartLabel
    };
    return Builder(builder: (context) {
      return BlocBuilder<DashboardAllocationCubit, DashboardChartsState>(
        builder: (context, state) {
          return state is GetAllocationLoaded
              ? Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(appLocalizations.home_label_totalNetWorth,
                                      style: const TextStyle(fontSize: 18)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              Icons.bar_chart,
                              size: 15,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 8),
                            Builder(builder: (context) {
                              return DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                                    items:
                                        List.generate(charts.length, (index) {
                                      log(appLocalizations
                                          .assets_charts_allocationCharts_areaChartLabel);
                                      return DropdownMenuItem<int>(
                                        value: index,
                                        child: Text(
                                          charts.values.elementAt(index),
                                          style: textTheme.bodyMedium!.apply(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      );
                                    }),
                                    onChanged: ((value) {
                                      if (value == 0) {
                                        setState(() {
                                          barChart = true;
                                        });
                                      } else {
                                        setState(() {
                                          barChart = false;
                                        });
                                      }
                                    }),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 15,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    value: barChart ? 0 : 1),
                              );
                            })
                          ],
                        ),
                        const SizedBox(height: 4),
                        Builder(builder: (context) {
                          final items = [
                            [
                              appLocalizations
                                  .home_dashboardCharts_legendLabel_netWorth,
                              barChart ? Theme.of(context).primaryColor : AppColors.chartColor
                            ],
                          ];
                          if (barChart) {
                            items.addAll(
                              [
                                [
                                  appLocalizations
                                      .home_dashboardCharts_legendLabel_assets,
                                  AppColors.chartColor
                                ],
                                [
                                  appLocalizations
                                      .home_dashboardCharts_legendLabel_liability,
                                  AppColors.redChartColor
                                ],
                              ],
                            );
                          }
                          return Row(
                            children: List.generate(items.length, (index) {
                              final item = items[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: index == 0 ? 1 : 8,
                                      width: index == 0 ? 12 : 8,
                                      color: item[1] as Color,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      item[0].toString(),
                                      style: textTheme.bodySmall,
                                    )
                                  ],
                                ),
                              );
                            }),
                          );
                        }),
                        AspectRatio(
                          aspectRatio:
                              ResponsiveHelper(context: context).isMobile
                                  ? 1.6
                                  : 2.2,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Builder(builder: (context) {
                              if (state.getAllocationEntity.isEmpty) {
                                return const EmptyChart();
                              }
                              return barChart
                                  ? PerformanceBarChart(
                                      allocations: state.getAllocationEntity,
                                    )
                                  : LineChartSample2(allocations: [
                                      ...state.getAllocationEntity,
                                    ]);
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const NetWorthChartShimmer();
        },
      );
    });
  }
}
