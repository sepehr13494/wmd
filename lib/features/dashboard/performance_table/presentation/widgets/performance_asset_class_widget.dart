import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/models/time_filer_obj.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/dashboard/performance_table/domain/entities/get_asset_class_entity.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/manager/performance_table_cubit.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/models/performance_value_obj.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/widgets/performance_base_table.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/widgets/performance_dropdown.dart';

import 'performance_table_shimmer.dart';

class PerformanceAssetClassWidget extends AppStatelessWidget {
  const PerformanceAssetClassWidget({Key? key}) : super(key: key);

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
                    appLocalizations.home_wealthPerformance_title,
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
                  bloc: context.watch<PerformanceAssetClassCubit>(),
                  function: (value) {
                    context
                        .read<PerformanceAssetClassCubit>()
                        .getAssetClass(period: value);
                  }),
            ],
          ),
        ),
        BlocConsumer<PerformanceAssetClassCubit, PerformanceTableState>(
          listener:
              BlocHelper.defaultBlocListener(listener: (context, state) {}),
          builder:
              BlocHelper.errorHandlerBlocBuilder(builder: (context, state) {
            return state is GetAssetClassLoaded
                ? Builder(builder: (context) {
                    List<GetAssetClassEntity> newList = [];
                    newList.addAll(state.getAssetClassEntities);
                    GetAssetClassEntity? total;
                    if (newList.isNotEmpty) {
                      total = GetAssetClassEntity(
                        assetName: appLocalizations
                            .home_wealthPerformance_table_header_total,
                        marketValue: newList
                            .map((e) => e.marketValue)
                            .reduce((a, b) => a + b),
                        forexValue: newList
                            .map((e) => e.forexValue)
                            .reduce((a, b) => a + b),
                        income: newList
                            .map((e) => e.income)
                            .reduce((a, b) => a + b),
                        commission: newList
                            .map((e) => e.commission)
                            .reduce((a, b) => a + b),
                        total:
                            newList.map((e) => e.total).reduce((a, b) => a + b),
                        changePercentage: newList
                            .map((e) => e.changePercentage)
                            .reduce((a, b) => a + b),
                      );
                      newList.add(total);
                    }
                    return PerformanceBaseTable(
                        titles: [
                          appLocalizations
                              .home_wealthPerformance_table_header_assetName,
                          appLocalizations
                              .home_wealthPerformance_table_header_marketResults,
                          appLocalizations
                              .home_wealthPerformance_table_header_forexResults,
                          appLocalizations
                              .home_wealthPerformance_table_header_income,
                          appLocalizations
                              .home_wealthPerformance_table_header_commissionAndExpense,
                          appLocalizations
                              .home_wealthPerformance_table_header_total,
                          appLocalizations
                              .home_wealthPerformance_table_header_changePercentage,
                        ],
                        widths: const [
                          130,
                          124,
                          114,
                          94,
                          120,
                          124,
                          104
                        ],
                        values: newList
                            .map((e) => <PerformanceValueObj>[
                                  PerformanceValueObj(
                                      value: e.assetName, shouldBlur: false),
                                  PerformanceValueObj(
                                    value: e.marketValue
                                        .convertMoney(addDollar: true),
                                  ),
                                  PerformanceValueObj(
                                    value: e.forexValue
                                        .convertMoney(addDollar: true),
                                  ),
                                  PerformanceValueObj(
                                    value:
                                        e.income.convertMoney(addDollar: true),
                                  ),
                                  PerformanceValueObj(
                                    value: e.commission
                                        .convertMoney(addDollar: true),
                                  ),
                                  PerformanceValueObj(
                                    value:
                                        e.total.convertMoney(addDollar: true),
                                  ),
                                  PerformanceValueObj(
                                      value:
                                          "${e.changePercentage.toStringAsFixedZero(1)} %",
                                      shouldBlur: false),
                                ])
                            .toList());
                  })
                : const PerformanceTableShimmer(
                    showTexts: false,
                  );
          }),
        )
      ],
    );
  }
}
