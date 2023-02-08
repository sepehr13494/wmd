import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/empty_chart.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/charts_cubit.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/chart_chooser.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';

import 'bar_charts_widget.dart';

class BaseAssetsOverviewChartsWidget extends AppStatelessWidget {
  const BaseAssetsOverviewChartsWidget({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: BlocBuilder<ChartsCubit, ChartsState>(
        builder: (context, state) {
          return state is GetChartLoaded
              ? state.getChartEntities.isEmpty ? const EmptyChart() : Column(
                  children: [
                    ChartChooserWidget(onChanged: (allBarType){

                    }),
                    Expanded(
                      child: AssetsOverviewBarCharts(
                          getChartEntities: state.getChartEntities),
                    ),
                    Builder(builder: (context) {
                      Set<String> titles = {};
                      for (var element in state.getChartEntities) {
                        if (element.bankAccount != 0) {
                          titles.add(AssetTypes.bankAccount);
                        }
                        if (element.realEstate != 0) {
                          titles.add(AssetTypes.realEstate);
                        }
                        if (element.listedAssetEquity != 0) {
                          titles.add(AssetTypes.listedAssetEquity);
                        }
                        if (element.listedAssetFixedIncome != 0) {
                          titles.add(AssetTypes.listedAssetFixedIncome);
                        }
                        if (element.listedAssetOther != 0) {
                          titles.add(AssetTypes.listedAssetOther);
                        }
                        if (element.others != 0) {
                          titles.add(AssetTypes.otherAsset);
                        }
                        if (element.privateDebt != 0) {
                          titles.add(AssetTypes.privateDebt);
                        }
                        if (element.privateEquity != 0) {
                          titles.add(AssetTypes.privateEquity);
                        }
                      }

                      return Wrap(
                        // spacing: 100, // gap between adjacent chips
                        runSpacing: 5, // gap between lines
                        children: List.generate(titles.length, (index) {
                          final item = titles.elementAt(index);
                          return SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AssetsOverviewChartsColors
                                          .colorsMap[item]??Colors.brown,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    AssetsOverviewChartsColors.getAssetType(
                                        appLocalizations, item),
                                    style: const TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      );
                    })
                  ],
                )
              : const LoadingWidget();
        },
      ),
    );
  }
}
