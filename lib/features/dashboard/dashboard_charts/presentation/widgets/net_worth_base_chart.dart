import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/dashboard/dashboard_charts/domain/entities/get_allocation_entity.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_allocation_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/line_chart.dart';
import 'package:wmd/injection_container.dart';

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
              ? state.getAllocationEntity.isEmpty
                  ? const SizedBox()
                  : Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Total Net Worth",
                                    style: TextStyle(fontSize: 18)),
                                const Spacer(),
                                Icon(
                                  Icons.bar_chart,
                                  size: 15,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(width: 8),
                                Builder(builder: (context) {
                                  final items = ["Bar Chart", "Area Chart"];
                                  return DropdownButton<String>(
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
                                      if (value == "Bar Chart") {
                                        setState(() {
                                          barChart = true;
                                        });
                                      } else {
                                        setState(() {
                                          barChart = false;
                                        });
                                      }
                                    }),
                                    value:
                                        barChart ? "Bar Chart" : "Area Chart",
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 15,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  );
                                })
                              ],
                            ),
                            const SizedBox(height: 12),
                            AspectRatio(
                              aspectRatio:
                                  ResponsiveHelper(context: context).isMobile
                                      ? 1.6
                                      : 2.2,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: barChart
                                    ? BarChartMainDashboard(
                                        allocations: state.getAllocationEntity)
                                    : LineChartSample2(allocations: [
                                        ...state.getAllocationEntity,
                                      ]),
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
