import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/empty_chart.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/charts_cubit.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/chart_chooser.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';

import '../manager/chart_chooser_manager.dart';
import 'assets_overview_area_chart.dart';
import 'assets_overview_tree_chart.dart';
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
              ? state.getChartEntities.isEmpty
                  ? const EmptyChart()
                  : Builder(
                    builder: (context) {
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
                      return Column(
                          children: [
                            const ChartChooserWidget(),
                            const SizedBox(height: 16),
                            Expanded(
                              child:
                                  BlocBuilder<ChartChooserManager, AllChartType?>(
                                builder: (context, chooseChartState) {
                                  if (chooseChartState == null) {
                                    return const SizedBox();
                                  } else {
                                    switch (chooseChartState.barType) {
                                      case BarType.barChart:
                                        return AssetsOverviewBarCharts(
                                            getChartEntities:
                                                state.getChartEntities);
                                      case BarType.areaChart:
                                        return AssetsOverviewAreaChart(
                                            getChartEntities:
                                                state.getChartEntities,titles:titles.toList());
                                      case BarType.treeChart:
                                        return AssetsOverviewTreeChart(
                                            getChartEntities:
                                                state.getChartEntities);
                                    }
                                  }
                                },
                              ),
                            ),
                            LayoutBuilder(
                              builder: (context,snap) {
                                int count = ResponsiveHelper(context: context).isDesktop? 3 : 2;
                                return GridView.count(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  crossAxisCount: count,
                                  childAspectRatio: (snap.maxWidth/count)/32,
                                  children: List.generate(titles.length, (index) {
                                    final item = titles.elementAt(index);
                                    return SizedBox(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(20, 4, 20, 4),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AssetsOverviewChartsColors
                                                    .colorsMap[item] ??
                                                    Colors.brown,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Align(
                                                alignment: AlignmentDirectional.centerStart,
                                                child: Text(
                                                  AssetsOverviewChartsColors.getAssetType(
                                                      appLocalizations, item),
                                                  style: const TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              }
                            ),
                          ],
                        );
                    }
                  )
              : const LoadingWidget();
        },
      ),
    );
  }
}
