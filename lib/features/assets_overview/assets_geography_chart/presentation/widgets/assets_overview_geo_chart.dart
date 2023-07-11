import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/presentation/geoTreeChartObj.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/widgets/chart_wrapper_box.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/chart_chooser_manager.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/chart_chooser.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';
import 'package:wmd/features/dashboard/dashboard_charts/domain/entities/get_geographic_entity.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/inside_world_map_widget.dart';

import '../../../charts/presentation/widgets/base_tree_chart_widget2.dart';
import '../manager/assets_geography_chart_cubit.dart';

class AssetsOverviewGeoChart extends AppStatelessWidget {
  const AssetsOverviewGeoChart({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return ChartWrapperBox(
      child: BlocBuilder<AssetsGeographyChartCubit, AssetsGeographyChartState>(
        builder: (context, state) {
          final isMobile = ResponsiveHelper(context: context).isMobile;
          return state is GetAssetsGeographyLoaded
              ? Builder(builder: (context) {
                  double sum = 0;
                  for (var element in state.assetsOverviewBaseModels) {
                    sum += element.totalAmount;
                  }
                  final List<GetGeographicEntity> baseGetGeographicEntity =
                      state.assetsOverviewBaseModels
                          .map((e) => GetGeographicEntity(
                              continent: e.geography,
                              amount: e.totalAmount,
                              percentage: (e.totalAmount / sum) * 100))
                          .toList();
                  return Column(
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
                                    child: BlocBuilder<GeoChartChooserManager,
                                        AllChartType?>(
                                      builder: (context, chooserState) {
                                        if (chooserState == null) {
                                          return const SizedBox();
                                        } else {
                                          switch (chooserState.barType) {
                                            case GeoBarType.map:
                                              return InsideWorldMapWidget(
                                                getGeographicEntity:
                                                    baseGetGeographicEntity,
                                              );
                                            case GeoBarType.tree:
                                              return BaseTreeChartWidget2<
                                                  GeoTreeChartObj>(
                                                treeChartObjs:
                                                    baseGetGeographicEntity
                                                        .map((e) => GeoTreeChartObj(
                                                            getGeographicEntity:
                                                                e))
                                                        .toList(),
                                                itemBuilder: (item, index) {
                                                  return Tooltip(
                                                    showDuration:
                                                        const Duration(
                                                            seconds: 5),
                                                    triggerMode:
                                                        TooltipTriggerMode.tap,
                                                    message:
                                                        "${item.getGeographicEntity.continent} : ${item.getGeographicEntity.percentage.toStringAsFixed(1)}%",
                                                    child: Container(
                                                      color:
                                                          AssetsOverviewChartsColors
                                                                  .treeMapColors[
                                                              index],
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2),
                                                        child: Text(
                                                          item.getGeographicEntity
                                                              .continent,
                                                          style: textTheme
                                                              .bodySmall,
                                                          overflow:
                                                              TextOverflow.clip,
                                                        ),
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
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            BlocBuilder<GeoChartChooserManager, AllChartType?>(
                              builder: (context, chartChooserState) {
                                return LayoutBuilder(builder: (context, snap) {
                                  final children = List.generate(
                                      baseGetGeographicEntity.length, (index) {
                                    final getGeographicEntity =
                                        baseGetGeographicEntity[index];
                                    return SizedBox(
                                      width: isMobile ? snap.maxWidth / 2 : 120,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.all(4),
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: chartChooserState
                                                            ?.barType ==
                                                        GeoBarType.map
                                                    ? InsideWorldMapWidgetState
                                                        .getColorByList(
                                                        getGeographicEntity
                                                            .continent,
                                                        baseGetGeographicEntity,
                                                      )
                                                    : AssetsOverviewChartsColors
                                                        .treeMapColors[index],
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: Align(
                                                alignment: AlignmentDirectional
                                                    .centerStart,
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
                                            ...children
                                                .map((e) => Expanded(child: e))
                                                .toList(),
                                            const SizedBox(height: 45)
                                          ],
                                        );
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                })
              : const LoadingWidget();
        },
      ),
    );
  }
}
