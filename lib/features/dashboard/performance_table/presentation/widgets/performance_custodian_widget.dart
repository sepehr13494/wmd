import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/manager/performance_table_cubit.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/models/performance_value_obj.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/widgets/performance_base_table.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/widgets/performance_dropdown.dart';

import 'performance_table_shimmer.dart';

class PerformanceCustodianWidget extends AppStatelessWidget {
  const PerformanceCustodianWidget({Key? key}) : super(key: key);

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
                    "Performance comparison of custodians",
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
                  bloc: context.watch<PerformanceCustodianCubit>(),
                  function: (value) {
                    context
                        .read<PerformanceCustodianCubit>()
                        .getCustodianPerformance(period: value);
                  }),
            ],
          ),
        ),
        BlocConsumer<PerformanceCustodianCubit,
            PerformanceTableState>(
          listener: BlocHelper.defaultBlocListener(
              listener: (context, state) {}),
          builder: BlocHelper.errorHandlerBlocBuilder(
              builder: (context, state) {
                return state is GetCustodianPerformanceLoaded
                    ? PerformanceBaseTable(
                    titles: const [
                      "Serial Number",
                      "Custodian Name",
                      "Performance (ITD)",
                      "Amount (USD)",
                      "Risk",
                      "Sharpe Ratio",
                    ],
                    widths: const [
                      120,
                      150,
                      120,
                      120,
                      80,
                      120
                    ],
                    values: state.getCustodianPerformanceEntities
                        .map((e) => <PerformanceValueObj>[
                      PerformanceValueObj(
                          value: "#${e.serialNumber}",
                          shouldBlur: false),
                      PerformanceValueObj(
                          value: e.custodianName),
                      PerformanceValueObj(
                          value:
                          "${e.performance.toStringAsFixed(1)} %",
                          shouldBlur: false),
                      PerformanceValueObj(
                          value:
                          "${e.amount.toStringAsFixed(1)} %",
                          shouldBlur: false),
                      PerformanceValueObj(
                          value:
                          "${e.riskPa.toStringAsFixed(1)} %",
                          shouldBlur: false),
                      PerformanceValueObj(
                          value: e.sharpeRatio
                              .toStringAsFixed(2)),
                    ])
                        .toList())
                    : const PerformanceTableShimmer(showTexts: false,);
              }),
        )
      ],
    );
  }
}
