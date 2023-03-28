import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/manager/performance_table_cubit.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/widgets/performance_base_table.dart';

import 'performance_table_shimmer.dart';

class PerformanceCustodianWidget extends AppStatelessWidget {
  const PerformanceCustodianWidget({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context,TextTheme textTheme, AppLocalizations appLocalizations) {
    return BlocConsumer<PerformanceCustodianCubit, PerformanceTableState>(
      listener: BlocHelper.defaultBlocListener(listener: (context, state) {}),
      builder: (context, state) {
        return state is GetCustodianPerformanceLoaded ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text("Performance comparison of custodians",
                style: textTheme.titleLarge,),
            ),
            PerformanceBaseTable(titles: const [
              "Serial Number",
              "Custodian Name",
              "Performance (ITD)",
              "Amount (USD)",
              "Risk",
              "Sharpe Ratio",
            ], widths: const [
              120,150,120,120,80,120
            ], values: state.getCustodianPerformanceEntities.map((e) => <String>[
              "#${e.serialNumber}",e.custodianName,"${e.performance.toStringAsFixed(1)} %","${e.amount.toStringAsFixed(1)} %","${e.riskPa.toStringAsFixed(1)} %",e.sharpeRatio.toStringAsFixed(2),
            ]).toList())
          ],
        ) : const PerformanceTableShimmer();
      },
    );
  }
}
