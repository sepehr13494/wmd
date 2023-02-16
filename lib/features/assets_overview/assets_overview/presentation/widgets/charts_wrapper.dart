import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/assets_overview_geo_chart.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/base_chart_view.dart';
import 'package:wmd/features/assets_overview/currency_chart/presentation/widgets/currency_chart_widget.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/inside_world_map_widget.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/random_map.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';

class ChartsWrapper extends AppStatelessWidget {
  const ChartsWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return BlocBuilder<MainDashboardCubit, MainDashboardState>(
        builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                appLocalizations.assets_charts_title,
                style: textTheme.bodyLarge,
              ),
              const SizedBox(width: 8),
              Text(
                '(${(context.read<MainDashboardCubit>().dateTimeRange ?? AppConstants.timeFilter(context).first).key})',
                style: textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 24),
          DefaultTabController(
            length: AppConstants.publicMvp2Items ? 3 : 1,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 300,
                      child: TabBar(
                        tabs: AppConstants.publicMvp2Items
                            ? [
                                Tab(
                                    text: appLocalizations
                                        .assets_charts_tabs_assetClass),
                                Tab(text: appLocalizations.assets_charts_tabs_geography),
                                Tab(text: appLocalizations.assets_charts_tabs_currency),
                              ]
                            : [
                                Tab(
                                    text: appLocalizations
                                        .assets_charts_tabs_assetClass),
                                // Tab(text: "Geography"),
                                // Tab(text: "Currency"),
                              ],
                        isScrollable: true,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const Divider(
                  height: 0.5,
                  thickness: 0.5,
                ),
                AspectRatio(
                  aspectRatio:
                      ResponsiveHelper(context: context).isMobile ? 1 : 1.6,
                  child: Builder(
                    builder: (context) {
                      List<Widget> children = [
                        const BaseAssetsOverviewChartsWidget(),
                      ];
                      if(AppConstants.publicMvp2Items){
                        children.addAll([
                          const AssetsOverviewGeoChart(),
                          const CurrencyChartWidget(),
                        ]);
                      }
                      return TabBarView(children: children.map((e) => Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                            ResponsiveHelper(context: context).biggerGap),
                        child: Card(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.darkCardColorForDarkTheme
                              : AppColors.darkCardColorForLightTheme,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: e,
                          ),
                        ),
                      ),).toList());
                    }
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}

class ChartPicker extends AppStatelessWidget {
  const ChartPicker({
    Key? key,
    required this.onChange,
    required this.value,
  }) : super(key: key);

  final void Function(int? value) onChange;
  final int value;

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<int>(
        items: [
          DropdownMenuItem<int>(
              value: 0,
              child: Row(
                children: [
                  Icon(
                    Icons.bar_chart,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(
                    'Bar Chart',
                    style: textTheme.bodyMedium!
                        .apply(color: Theme.of(context).primaryColor),
                    // textTheme.bodyMedium!.toLinkStyle(context),
                  ),
                ],
              ))
        ],
        onChanged: onChange,
        value: value,
        icon: Icon(
          Icons.keyboard_arrow_down,
          size: 15,
          color: Theme.of(context).primaryColor,
        ),
        // style: textTheme.labelLarge,
      ),
    );
  }
}
