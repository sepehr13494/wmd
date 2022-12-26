import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/charts_cubit.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/charts_widget.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';

class BaseAssetsOverviewChartsWidget extends AppStatelessWidget {
  const BaseAssetsOverviewChartsWidget({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return BlocBuilder<ChartsCubit, ChartsState>(
      builder: (context, state) {
        return state is GetChartLoaded
            ? Column(
                children: [
                  AspectRatio(
                    aspectRatio:
                        ResponsiveHelper(context: context).isMobile ? 1.6 : 2.2,
                    child: AssetsOverviewCharts(
                        getChartEntities: state.getChartEntities),
                  ),
                  Builder(builder: (context) {
                    Set<String> titles = {};
                    state.getChartEntities.forEach((element) {
                      if (element.bankAccount != 0) {
                        titles.add(AssetTypes.bankAccount);
                      }
                      if (element.listedAsset != 0) {
                        titles.add(AssetTypes.listedAsset);
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
                    });

                    return Wrap(
                      children: List.generate(titles.length, (index) {
                        final item = titles.elementAt(index);
                        return Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AssetsOverviewChartsColors
                                      .colorsMap[item],
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                AssetsOverviewChartsColors.getAssetType(
                                    appLocalizations, item),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        );
                      }),
                    );
                  })
                ],
              )
            : const LoadingWidget();
      },
    );
  }
}
