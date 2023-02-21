import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';
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
            ? RowOrColumn(
                showRow: !isMobile,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: InsideWorldMapWidget(
                            getGeographicEntity: state.getGeographicEntity,
                          ),
                        ),
                        const SizedBox(height: 12),
                        LayoutBuilder(builder: (context, snap) {
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
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Builder(builder: (context) {
                      final continents = [
                        "Asia",
                        "Europe",
                        "Oceania",
                        "Africa",
                        "North America",
                        "South America",
                      ];
                      final children = List.generate(6, (index) {
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
                                            continents[index],
                                            state.getGeographicEntity),
                                      )),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        AssetsOverviewChartsColors.getContinentsNames(
                                            appLocalizations, continents[index]),
                                        style: textTheme.bodySmall,
                                      ),
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
              )
            : const LoadingWidget();
      },
    );
  }
}
