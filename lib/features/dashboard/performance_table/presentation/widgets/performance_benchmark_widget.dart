import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/widgets/performance_base_table.dart';

import '../manager/performance_table_cubit.dart';
import 'performance_table_shimmer.dart';

class PerformanceBenchmarkWidget extends AppStatelessWidget {
  const PerformanceBenchmarkWidget({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context,TextTheme textTheme, AppLocalizations appLocalizations) {
    return BlocConsumer<PerformanceBenchmarkCubit, PerformanceTableState>(
      listener: BlocHelper.defaultBlocListener(listener: (context, state) {}),
      builder: (context, state) {
        return state is GetBenchmarkLoaded ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(appLocalizations.home_wealthPerformanceComparision_title,
                style: textTheme.titleLarge,),
            ),
            Builder(
              builder: (context) {
                return PerformanceBaseTable(titles: [
                  appLocalizations.home_wealthPerformanceComparision_table_header_indexes,
                  appLocalizations.home_wealthPerformanceComparision_table_header_performance,
                  appLocalizations.home_wealthPerformanceComparision_table_header_performancePA,
                  appLocalizations.home_wealthPerformanceComparision_table_header_riskPA,
                  appLocalizations.home_wealthPerformanceComparision_table_header_sharpeRatio,
                ], widths: const [
                  120,120,120,100,120
                ], values: state.getBenchmarkEntities.map((e) => <String>[
                  e.index,"${e.performance.toStringAsFixed(1)} %","${e.performancePa.toStringAsFixed(1)} %","${e.riskPa.toStringAsFixed(1)} %",e.sharpeRatio.toString()
                ]).toList());
              }
            )
          ],
        ) : const PerformanceTableShimmer();
      },
    );
  }
}
