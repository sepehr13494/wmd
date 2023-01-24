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
import '../manager/dashboard_charts_cubit.dart';
import 'bar_chart.dart';

class NetWorthBaseChart extends StatefulWidget {
  const NetWorthBaseChart({Key? key}) : super(key: key);

  @override
  AppState<NetWorthBaseChart> createState() => _NetWorthBaseChartState();
}

class _NetWorthBaseChartState extends AppState<NetWorthBaseChart> {
  bool barChart = false;

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
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
                            Text(appLocalizations.home_label_totalNetWorth,
                                style: const TextStyle(fontSize: 18)),
                            const Spacer(),
                            Icon(
                              Icons.bar_chart,
                              size: 15,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 8),
                            Builder(builder: (context) {
                              final items = [
                                appLocalizations
                                    .assets_charts_allocationCharts_barChartLabel,
                                appLocalizations
                                    .assets_charts_allocationCharts_areaChartLabel
                              ];
                              return DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    items: List.generate(2, (index) {
                                      return DropdownMenuItem<String>(
                                        value: items[index],
                                        child: Text(
                                          items[index],
                                          style: textTheme.bodyMedium!.apply(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      );
                                    }),
                                    onChanged: ((value) {
                                      if (value ==
                                          appLocalizations
                                              .assets_charts_allocationCharts_barChartLabel) {
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
                                    value: barChart
                                        ? appLocalizations
                                            .assets_charts_allocationCharts_barChartLabel
                                        : appLocalizations
                                            .assets_charts_allocationCharts_areaChartLabel),
                              );
                            })
                          ],
                        ),
                        const SizedBox(height: 4),
                        barChart
                            ? Builder(
                              builder: (context) {
                                final items = [
                                  [appLocalizations.home_dashboardCharts_legendLabel_netWorth,AppColors.chartColor],
                                  [appLocalizations.home_dashboardCharts_legendLabel_assets,AppColors.chartColor],
                                  [appLocalizations.home_dashboardCharts_legendLabel_liability,AppColors.redChartColor],
                                ];
                                return Row(
                          children: List.generate(3, (index) {
                                final item = items[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: index == 0 ? 1 : 8,
                                        width: index == 0 ? 12 :  8,
                                        color: item[1] as Color,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(item[0].toString(),style: textTheme.bodySmall,)
                                    ],
                                  ),
                                );
                          }),
                        );
                              }
                            ) : const SizedBox(),
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
                                  ? BarChartMainDashboard(
                                      allocations: state.getAllocationEntity)
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
              : const LoadingWidget();
        },
      );
    });
  }
}
