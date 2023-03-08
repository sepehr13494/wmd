import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/tab_manager.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';
import 'package:wmd/features/dashboard/dashboard_charts/domain/entities/get_pie_entity.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_charts_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/base_asset_view.dart';

import '../manager/dashboard_pie_cubit.dart';
import '../models/each_asset_model.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  AppState<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends AppState {
  int touchedIndex = -1;

  Timer? timer;

  @override
  void dispose() {
    if(timer != null){
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Builder(builder: (context) {
      return BlocBuilder<DashboardPieCubit, DashboardChartsState>(
        builder: (context, state) {
          if (state is GetPieLoaded) {
            final isEmpty =
                state.getPieEntity.where((e) => e.percentage != 0).isEmpty;

            return BaseAssetView(
              title: appLocalizations.home_widget_assetClassAllocation_title,
              secondTitle: appLocalizations
                  .home_widget_assetClassAllocation_label_assetClass,
              assets: isEmpty
                  ? []
                  : List.generate(
                      state.getPieEntity.length,
                      (index) {
                        GetPieEntity pieEntity = state.getPieEntity[index];
                        return EachAssetViewModel(
                          color: AssetsOverviewChartsColors
                                  .colorsMapPie[pieEntity.name] ??
                              Colors.brown,
                          name: AssetsOverviewChartsColors.getAssetType(
                              appLocalizations, pieEntity.name,
                              category: pieEntity.subType),
                          price: pieEntity.value.convertMoney(addDollar: true),
                          value: pieEntity.value,
                          percentage:
                              "${pieEntity.percentage.toStringAsFixed(1)}%",
                        );
                      },
                    ),
              onMoreTap: () {
                context.read<TabManager>().changeTab(0);
              },
              emptyChild: _buildEmptyChart(appLocalizations, textTheme),
              child: LayoutBuilder(builder: (context, snap) {
                final double height = snap.maxWidth * 0.65;
                final inside = height / 5;
                return SizedBox(
                  height: height,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: PieChart(PieChartData(sections: [
                            PieChartSectionData(
                              color: Colors.white12,
                              value: 100,
                              title: '',
                              radius: (height - inside) / 4,
                            )
                          ])),
                        ),
                      PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                                if(timer != null){
                                  timer!.cancel();
                                }
                                timer = Timer(const Duration(seconds: 2), () {
                                  setState(() {
                                    touchedIndex = -1;
                                  });
                                });
                              });
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: inside,
                          sections: showingSections(
                              (height - inside) / 4, state.getPieEntity),
                        ),
                      ),
                      touchedIndex != -1
                          ? Builder(builder: (context) {
                              GetPieEntity pieEntity =
                                  state.getPieEntity[touchedIndex];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.anotherCardColorForDarkTheme,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                        AssetsOverviewChartsColors.getAssetType(
                                            appLocalizations, pieEntity.name),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          pieEntity.value
                                              .convertMoney(addDollar: true),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!,
                                        ),
                                        const SizedBox(width: 24),
                                        Text(
                                          "${pieEntity.percentage.toStringAsFixed(1)} %",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .apply(
                                                  color: AppColors.chartColor),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            })
                          : const SizedBox()
                    ],
                  ),
                );
              }),
            );
          } else {
            return const LoadingWidget();
          }
        },
      );
    });
  }

  List<PieChartSectionData> showingSections(
      double outside, List<GetPieEntity> getPieEntity) {
    return List.generate(getPieEntity.length, (index) {
      final pieStrokeWidth = outside;
      final isTouched = index == touchedIndex;
      final radius = isTouched ? pieStrokeWidth + 10 : pieStrokeWidth;
      GetPieEntity pieEntity = getPieEntity[index];
      return PieChartSectionData(
        color: AssetsOverviewChartsColors.colorsMapPie[pieEntity.name] ??
            Colors.brown,
        value: pieEntity.percentage,
        title: '',
        radius: radius,
      );
    });
  }
}

Widget _buildEmptyChart(
    AppLocalizations appLocalizations, TextTheme textTheme) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 24),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          appLocalizations.common_emptyText_title,
          style: textTheme.bodyLarge,
        ),
        Text(
          appLocalizations.common_emptyText_assetClassDescription,
          textAlign: TextAlign.center,
          style: textTheme.bodySmall,
        ),
      ],
    ),
  );
}
