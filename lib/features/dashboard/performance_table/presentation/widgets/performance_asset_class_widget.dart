import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/manager/performance_table_cubit.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/widgets/performance_base_table.dart';

import 'performance_table_shimmer.dart';

class PerformanceAssetClassWidget extends AppStatelessWidget {
  const PerformanceAssetClassWidget({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return BlocConsumer<PerformanceAssetClassCubit, PerformanceTableState>(
      listener: BlocHelper.defaultBlocListener(listener: (context, state) {}),
      builder: (context, state) {
        return state is GetAssetClassLoaded
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      appLocalizations.home_wealthPerformance_title,
                      style: textTheme.headlineSmall,
                    ),
                  ),
                  PerformanceBaseTable(
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
                        140,
                        130,
                        120,
                        100,
                        100,
                        130,
                        80
                      ],
                      values: state.getAssetClassEntities
                          .map((e) => <String>[
                                e.assetName,
                                e.marketValue.convertMoney(addDollar: true),
                                e.forexValue.convertMoney(addDollar: true),
                                e.income.convertMoney(addDollar: true),
                                e.commision.convertMoney(addDollar: true),
                                e.total.convertMoney(addDollar: true),
                                "${e.changePercentage.toStringAsFixed(1)} %",
                              ])
                          .toList())
                ],
              )
            : const PerformanceTableShimmer();
      },
    );
  }
}
