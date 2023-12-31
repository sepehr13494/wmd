import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/bloc/bloc_helpers.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/empty_chart.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/widgets/chart_wrapper_box.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/charts_cubit.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/chart_chooser.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/shimmers/bar_chart_shimmer.dart';

import '../manager/chart_chooser_manager.dart';
import '../models/color_title_obj.dart';
import 'assets_overview_area_chart.dart';
import 'assets_overview_tree_chart.dart';
import 'bar_charts_widget.dart';
import 'color_with_title_widget.dart';

class BaseAssetsOverviewChartsWidget extends AppStatelessWidget {
  const BaseAssetsOverviewChartsWidget({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: BlocConsumer<ChartsCubit, ChartsState>(
        listener: BlocHelper.defaultBlocListener(listener: (context, state) {}),
        builder: BlocHelper.errorHandlerBlocBuilder(builder: (context, state) {
          return state is GetChartLoaded
              ? state.getChartEntities.isEmpty
                  ? const SizedBox()
                  : ChartWrapperBox(child: Builder(builder: (context) {
            Set<String> titles = {};
            for (var element in state.getChartEntities) {
              if (element.bankAccount != 0) {
                titles.add(AssetTypes.bankAccount);
              }
              if (element.listedAssetEquity != 0) {
                titles.add(AssetTypes.listedAssetEquity);
              }
              if (element.privateEquity != 0) {
                titles.add(AssetTypes.privateEquity);
              }
              if (element.privateDebt != 0) {
                titles.add(AssetTypes.privateDebt);
              }
              if (element.realEstate != 0) {
                titles.add(AssetTypes.realEstate);
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
            }
            return Column(
              children: [
                ChartChooserWidget(
                  isGeo: false,
                  show: AppConstants.publicMvp2Items,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: BlocBuilder<AssetChartChooserManager,
                      AllChartType?>(
                    builder: (context, chooseChartState) {
                      if (chooseChartState == null) {
                        return const SizedBox();
                      } else {
                        switch (chooseChartState.barType) {
                          case AssetsBarType.barChart:
                            return AssetsOverviewBarCharts(
                                getChartEntities:
                                state.getChartEntities);
                          case AssetsBarType.areaChart:
                            return AssetsOverviewAreaChart(
                                getChartEntities:
                                state.getChartEntities,
                                titles: titles
                                    .toList()
                                    .reversed
                                    .toList());
                          case AssetsBarType.areaPercentage:
                            return AssetsOverviewAreaChart(
                              getChartEntities:
                              state.getChartEntities,
                              titles:
                              titles.toList().reversed.toList(),
                              showPercentage: true,
                            );
                          case AssetsBarType.tree:
                            return AssetsOverviewTreeChart(
                                getChartEntities:
                                state.getChartEntities);
                          default:
                            return const SizedBox();
                        }
                      }
                    },
                  ),
                ),
                ColorsWithTitlesWidget(
                  colorTitles: titles
                      .map((e) => ColorTitleObj(
                      title: AssetsOverviewChartsColors
                          .getAssetType(appLocalizations, e),
                      color: (AssetsOverviewChartsColors
                          .colorsMap[e] ??
                          Colors.brown)))
                      .toList(),
                  axisColumnCount:
                  ResponsiveHelper(context: context).isDesktop
                      ? 3
                      : 2,
                ),
              ],
            );
          }),)
              : const ChartWrapperBox(
                  child: BarChartShimmer(),
                );
        }),
      ),
    );
  }
}
