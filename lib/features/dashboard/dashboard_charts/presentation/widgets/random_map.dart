import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/tab_manager.dart';
import 'package:wmd/features/dashboard/dashboard_charts/domain/entities/get_geographic_entity.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_charts_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/base_asset_view.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/inside_world_map_widget.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/shimmer/map_chart_shimmer.dart';

import '../../data/models/get_geographic_response.dart';
import '../manager/dashboard_goe_cubit.dart';
import '../models/each_asset_model.dart';

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
          appLocalizations.common_emptyText_mapDescription,
          textAlign: TextAlign.center,
          style: textTheme.bodySmall,
        ),
      ],
    ),
  );
}

class RandomWorldMapGenrator extends StatefulWidget {
  const RandomWorldMapGenrator({Key? key}) : super(key: key);

  @override
  AppState<StatefulWidget> createState() => _RandomWorldMapGenratorState();
}

class _RandomWorldMapGenratorState extends AppState<RandomWorldMapGenrator> {
  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Builder(builder: (context) {
      return BlocBuilder<DashboardGoeCubit, DashboardChartsState>(
        builder: (context, state) {
          return state is GetGeographicLoaded
              ? BaseAssetView(
                  title: appLocalizations.home_widget_geography_title,
                  secondTitle:
                      appLocalizations.home_widget_geography_label_continents,
                  emptyChild: _buildEmptyChart(appLocalizations, textTheme),
                  assets: List.generate(
                    state.getGeographicEntity.length,
                    (index) {
                      GetGeographicEntity geographicEntity =
                          state.getGeographicEntity[index];
                      return EachAssetViewModel(
                        name: geographicEntity.continent,
                        price: geographicEntity.amount
                            .convertMoney(addDollar: true),
                        value: geographicEntity.amount,
                        percentage:
                            "${geographicEntity.percentage.toStringAsFixed(1)}%",
                      );
                    },
                  ),
                  onMoreTap: () {
                    context.read<TabManager>().changeTab(1);
                  },
                  child: InsideWorldMapWidget(
                      getGeographicEntity: state.getGeographicEntity),
                )
              : const MapChartShimmer();
        },
      );
    });
  }
}
