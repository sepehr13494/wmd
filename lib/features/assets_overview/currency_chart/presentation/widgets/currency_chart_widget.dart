import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/assets_overview/currency_chart/presentation/manager/currency_chart_cubit.dart';
import 'package:wmd/injection_container.dart';

class CurrencyChartWidget extends AppStatelessWidget {
  const CurrencyChartWidget({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return BlocProvider(
      create: (context) =>
      sl<CurrencyChartCubit>()
        ..getCurrency(),
      child: Builder(
          builder: (context) {
            return BlocBuilder<CurrencyChartCubit, CurrencyChartState>(
              builder: (context, state) {
                return Text(state is GetCurrencyLoaded ? jsonEncode(state.getCurrencyEntities) : "");
              },
            );
          }
      ),
    );
  }
}
