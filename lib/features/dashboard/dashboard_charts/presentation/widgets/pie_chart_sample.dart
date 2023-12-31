import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/tab_manager.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';
import 'package:wmd/features/dashboard/dashboard_charts/domain/entities/get_pie_entity.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_charts_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/base_asset_view.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/shimmer/pie_chart_shimmer.dart';

import '../manager/dashboard_pie_cubit.dart';
import '../models/each_asset_model.dart';
import 'inside_pie_chart.dart';

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
    if (timer != null) {
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
              child: InsidePieChart(eachAssetViewModels: state.getPieEntity.map((e) => EachAssetViewModel.fromPieEntity(e,appLocalizations)).toList()),
            );
          } else {
            return const PieChartShimmer();
          }
        },
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
