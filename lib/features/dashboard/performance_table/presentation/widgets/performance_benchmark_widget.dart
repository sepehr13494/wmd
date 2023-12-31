import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/dashboard/performance_table/client_index/presentation/manager/client_index_cubit.dart';
import 'package:wmd/features/dashboard/performance_table/domain/entities/get_benchmark_entity.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/models/performance_value_obj.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/widgets/performance_base_table.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/widgets/performance_dropdown.dart';
import 'package:wmd/global_functions.dart';

import '../../client_index/domain/entities/get_client_index_entity.dart';
import '../manager/performance_table_cubit.dart';
import 'performance_table_shimmer.dart';

class PerformanceBenchmarkWidget extends AppStatelessWidget {
  const PerformanceBenchmarkWidget({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    appLocalizations.home_wealthPerformanceComparision_title,
                    style: textTheme.titleLarge,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.calendar_month,
                size: 15,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 8),
              PerformanceDropdown(
                  customItems: AppConstants.timeFilterOnlyDays(context),
                  bloc: context.watch<PerformanceBenchmarkCubit>(),
                  function: (value) {
                    context
                        .read<PerformanceBenchmarkCubit>()
                        .getBenchmark(period: value);
                    context
                        .read<ClientIndexCubit>()
                        .getClientIndex(period: value);
                  }),
            ],
          ),
        ),
        BlocConsumer<PerformanceBenchmarkCubit, PerformanceTableState>(
          listener:
              BlocHelper.defaultBlocListener(listener: (context, state) {}),
          builder: BlocHelper.errorHandlerBlocBuilder(
            builder: (context, state) {
              return state is GetBenchmarkLoaded
                  ? Builder(builder: (context) {
                List<GetBenchmarkEntity> newList = [];
                newList.addAll(state.getBenchmarkEntities);
                      return BlocBuilder<ClientIndexCubit, ClientIndexState>(
                        builder: (context, clientIndexState) {
                          if (clientIndexState is GetClientIndexLoaded) {
                            newList = [];
                            newList.addAll(state.getBenchmarkEntities);
                            newList.insert(
                              0,
                              GetClientIndexEntity.benchMarkFromClient(
                                getClientIndexEntity:
                                    clientIndexState.getClientIndexEntity,
                              ),
                            );
                          }
                          return PerformanceBaseTable(
                              titles: [
                                appLocalizations
                                    .home_wealthPerformanceComparision_table_header_indexes,
                                appLocalizations
                                    .home_wealthPerformanceComparision_table_header_performance,
                                appLocalizations
                                    .home_wealthPerformanceComparision_table_header_performancePA,
                                appLocalizations
                                    .home_wealthPerformanceComparision_table_header_riskPA,
                                appLocalizations
                                    .home_wealthPerformanceComparision_table_header_sharpeRatio,
                              ],
                              widths: const [
                                120,
                                120,
                                120,
                                100,
                                120
                              ],
                              values: newList
                                  .map((e) => <PerformanceValueObj>[
                                        PerformanceValueObj(
                                            value: e.index, shouldBlur: false),
                                        PerformanceValueObj(
                                            value: e.performance == null ? "n/a" :
                                                "${e.performance!.toStringAsFixedZero(1)} %",
                                            shouldBlur: false),
                                        PerformanceValueObj(
                                            value: e.performancePa == null ? "n/a" :
                                            "${e.performancePa!.toStringAsFixedZero(1)} %",
                                            shouldBlur: false,
                                          showTooltip: GlobalFunctions.showPercentageTooltip(e.performancePa??0)
                                        ),
                                        PerformanceValueObj(
                                            value: e.riskPa == null ? "n/a" :
                                                "${e.riskPa!.toStringAsFixedZero(1)} %",
                                            shouldBlur: false),
                                        PerformanceValueObj(
                                            value: e.sharpeRatio == null ? "n/a" : e.sharpeRatio
                                                !.toStringAsFixedZero(1),
                                            shouldBlur: true,
                                        ),
                                      ])
                                  .toList());
                        },
                      );
                    })
                  : const PerformanceTableShimmer(
                      showTexts: false,
                    );
            },
          ),
        )
      ],
    );
  }
}
