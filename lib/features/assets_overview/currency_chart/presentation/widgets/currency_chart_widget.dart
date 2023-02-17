import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/base_tree_chart_widget.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';
import 'package:wmd/features/assets_overview/currency_chart/domain/entities/get_currency_entity.dart';
import 'package:wmd/features/assets_overview/currency_chart/presentation/manager/currency_chart_cubit.dart';
import 'package:wmd/injection_container.dart';

class CurrencyTreeObj extends TreeChartObj {
  final GetCurrencyEntity currencyEntity;

  CurrencyTreeObj({required this.currencyEntity})
      : super(value: currencyEntity.totalAmount);

  @override
  List<Object?> get props => [
        currencyEntity.currencyCode,
      ];
}

class CurrencyChartWidget extends AppStatelessWidget {
  const CurrencyChartWidget({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return BlocProvider(
      create: (context) => sl<CurrencyChartCubit>()..getCurrency(),
      child: Builder(builder: (context) {
        return BlocConsumer<CurrencyChartCubit, CurrencyChartState>(
          listener: BlocHelper.defaultBlocListener(
            listener: (context, state) {},
          ),
          builder: (context, state) {
            return state is GetCurrencyLoaded
                ? BaseTreeChartWidget<CurrencyTreeObj>(
                    treeChartObjs: state.getCurrencyEntities
                        .map((e) => CurrencyTreeObj(currencyEntity: e))
                        .toList(),
                    itemBuilder: (item) {
                      return Container(
                        margin: const EdgeInsets.all(0.5),
                        color: AssetsOverviewChartsColors.colors[Random().nextInt(7)],
                        child: Text(
                          item.currencyEntity.totalAmount.toString(),
                        ),
                      );
                    },
                  )
                : const LoadingWidget();
          },
        );
      }),
    );
  }
}
