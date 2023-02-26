import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/presentation/geoTreeChartObj.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/chart_chooser_manager.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/chart_chooser_manager.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/base_tree_chart_widget.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/chart_chooser.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_charts_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_goe_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/inside_world_map_widget.dart';

class AssetsOverviewGeoChart extends AppStatelessWidget {
  const AssetsOverviewGeoChart({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return BlocBuilder<DashboardGoeCubit, DashboardChartsState>(
      builder: (context, state) {
        final isMobile = ResponsiveHelper(context: context).isMobile;
        return state is GetGeographicLoaded
            ? Column(
          children: [
            const ChartChooserWidget(isGeo: true),
            const SizedBox(height: 8),
            Expanded(
              child: RowOrColumn(
                showRow: !isMobile,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: BlocBuilder<GetChartChooserManager, AllChartType?>(
                            builder: (context, chooserState) {
                              if(chooserState == null){
                                return const SizedBox();
                              }else{
                                switch (chooserState.barType){
                                  case GeoBarType.map:
                                    return InsideWorldMapWidget(
                                      getGeographicEntity: state.getGeographicEntity,
                                    );
                                  case GeoBarType.tree:
                                    return BaseTreeChartWidget(
                                      treeChartObjs: state.getGeographicEntity.map((e) => GeoTreeChartObj(getGeographicEntity: e)).toList(),
                                      itemBuilder: (item, index) {
                                        return Tooltip(
                                          message: "${item.getGeographicEntity.continent} : ${item.getGeographicEntity.percentage.toStringAsFixed(1)}%",
                                          child: Container(
                                            margin: const EdgeInsets.all(0.5),
                                            color: InsideWorldMapWidgetState.getColor(
                                              InsideWorldMapWidgetState.getPercentage(
                                                  item.getGeographicEntity.continent,
                                                  state.getGeographicEntity),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: Text(item.getGeographicEntity.continent,style: textTheme.bodySmall,overflow: TextOverflow.clip,),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  default:
                                    return const SizedBox();
                                }
                              }

                            },
                          ),
                        ),
                        /*LayoutBuilder(builder: (context, snap) {
                                return Container(
                                  width: snap.maxWidth * 0.6,
                                  constraints: const BoxConstraints(
                                    maxWidth: 250,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 13,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            gradient: const LinearGradient(colors: [
                                              AppColors.continentEmptyColor,
                                              AppColors.continentFullColor
                                            ])),
                                      ),
                                      Builder(builder: (context) {
                                        final items = ["0%", "45%", "60%"];
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: List.generate(3, (index) {
                                            return Text(
                                              items[index],
                                              style: textTheme.bodySmall,
                                            );
                                          }),
                                        );
                                      })
                                    ],
                                  ),
                                );
                              }),*/
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Builder(builder: (context) {
                      final children = List.generate(state.getGeographicEntity
                          .length, (index) {
                        final getGeographicEntity = state
                            .getGeographicEntity[index];
                        return SizedBox(
                          width: 120,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(4),
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: InsideWorldMapWidgetState.getColor(
                                        InsideWorldMapWidgetState.getPercentage(
                                            getGeographicEntity.continent,
                                            state.getGeographicEntity),
                                      )),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      getGeographicEntity.continent,
                                      style: textTheme.bodySmall,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                      return isMobile
                          ? Wrap(
                        children: children,
                      )
                          : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20),
                          ...children.map((e) => Expanded(child: e)).toList(),
                          const SizedBox(height: 45)
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        )
            : const LoadingWidget();
      },
    );
  }
}
