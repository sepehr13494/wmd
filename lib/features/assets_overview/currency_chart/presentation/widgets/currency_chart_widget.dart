import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/base_tree_chart_widget.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/color_with_title_widget.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';
import 'package:wmd/features/assets_overview/currency_chart/domain/entities/get_currency_entity.dart';
import 'package:wmd/features/assets_overview/currency_chart/presentation/manager/currency_chart_cubit.dart';
import 'package:wmd/injection_container.dart';

import '../../../charts/presentation/models/color_title_obj.dart';
import '../../../charts/presentation/widgets/base_tree_chart_widget2.dart';

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
    return BlocConsumer<CurrencyChartCubit, CurrencyChartState>(
      listener: BlocHelper.defaultBlocListener(
        listener: (context, state) {},
      ),
      builder: (context, state) {
        return state is GetCurrencyLoaded
            ? Builder(
            builder: (context) {
              double sum = 0;
              for (var element in state.assetsOverviewBaseModels) {
                sum += element.totalAmount;
              }
              return Column(
                children: [
                  Expanded(
                    child: BaseTreeChartWidget2<CurrencyTreeObj>(
                      treeChartObjs: state.assetsOverviewBaseModels
                          .map((e) => CurrencyTreeObj(currencyEntity: e))
                          .toList(),
                      itemBuilder: (item,itemIndex) {
                        return Tooltip(
                          triggerMode: TooltipTriggerMode.tap,
                          message: "${item.currencyEntity.currencyCode}: ${((item.value*100)/sum).toStringAsFixed(1)} %",
                          child: Container(
                            color: AssetsOverviewChartsColors.treeMapColors[itemIndex],
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Text(
                                item.currencyEntity.currencyCode,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  ColorsWithTitlesWidget(colorTitles: List.generate(state.assetsOverviewBaseModels.length, (index) {
                    GetCurrencyEntity item = state.assetsOverviewBaseModels[index];
                    return ColorTitleObj(title: item.currencyCode,color: AssetsOverviewChartsColors.treeMapColors[index]);
                  }),axisColumnCount: ResponsiveHelper(context: context).isDesktop ? 5 : 3,)
                ],
              );
            }
        )
            : const LoadingWidget();
      },
    );
  }
}
