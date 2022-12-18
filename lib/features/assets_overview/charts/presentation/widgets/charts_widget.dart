import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/charts_cubit.dart';
import 'package:wmd/injection_container.dart';

class AssetsOverviewCharts extends AppStatelessWidget {
  const AssetsOverviewCharts({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Builder(
        builder: (context) {
          return BlocConsumer<ChartsCubit, ChartsState>(
            listener: BlocHelper.defaultBlocListener(listener: ((context, state) {})),
            builder: (context, state) {
              return Container(child: InkWell(onTap: () {
                context.read<ChartsCubit>().getChart(to: DateTime.now());
              }, child: Text("charts")),);
            },
          );
        }
    );
  }
}
