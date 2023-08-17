import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/asset_detail/core/presentation/widgets/as_of_date_widget.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/tab_manager.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/presentation/widgets/assets_overview_geo_chart.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/base_chart_view.dart';
import 'package:wmd/features/assets_overview/currency_chart/presentation/widgets/currency_chart_widget.dart';
import 'package:wmd/features/assets_overview/portfolio_tab2/presentation/widgets/portfolio_chart_widget.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';

class ChartsWrapper extends StatefulWidget {
  const ChartsWrapper({
    Key? key,
  }) : super(key: key);

  @override
  AppState<ChartsWrapper> createState() => _ChartsWrapperState();
}

class _ChartsWrapperState extends AppState<ChartsWrapper>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(
        length: 4, vsync: this, initialIndex: context.read<TabManager>().state);
    _controller.addListener(() {
      context.read<TabManager>().changeTab(_controller.index);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return BlocBuilder<SummeryWidgetCubit, MainDashboardState>(
        builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                appLocalizations.assets_charts_title,
                style: textTheme.titleLarge,
              ),
              const SizedBox(width: 8),
              BlocBuilder<TabManager, int>(
                builder: (context, state) {
                  return state == 0
                      ? Text(
                          '(${(context.read<SummeryWidgetCubit>().dateTimeRange ?? AppConstants.timeFilter(context).first).key})',
                          style: textTheme.bodySmall,
                        )
                      : BlocBuilder<SummeryWidgetCubit, MainDashboardState>(
                          builder: (context, state) {
                            return state is MainDashboardNetWorthLoaded
                                ? AsOfDateWidget(
                                    shownDate: DateTime.parse(
                                        state.netWorthObj.lastUpdated),
                                    asOf: true,
                                  )
                                : const SizedBox();
                          },
                        );
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          Column(
            children: [
              Builder(builder: (context) {
                final isMobile = ResponsiveHelper(context: context).isMobile;
                return LayoutBuilder(builder: (context, snap) {
                  return Row(
                    children: [
                      SizedBox(
                        width: isMobile ? snap.maxWidth : 400,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: TabBar(
                            indicatorPadding: EdgeInsets.zero,
                            labelPadding: EdgeInsets.zero,
                            labelStyle: textTheme.titleSmall,
                            controller: _controller,
                            tabs: [
                              Tab(
                                text:
                                    "  ${appLocalizations.assets_charts_tabs_assetClass}  ",
                              ),
                              Tab(
                                  text:
                                      "  ${appLocalizations.assets_charts_tabs_geography}  "),
                              AppConstants.isRelease2
                                  ? Tab(
                                      text:
                                          "  ${appLocalizations.assets_charts_tabs_currency}  ")
                                  : SizedBox(),
                              Tab(
                                  text:
                                      "  ${appLocalizations.assets_charts_tabs_portfolio}  "),
                            ],
                            isScrollable: true,
                          ),
                        ),
                      ),
                      isMobile ? const SizedBox() : const Spacer(),
                    ],
                  );
                });
              }),
              const Divider(
                height: 0.5,
                thickness: 0.5,
              ),
              Builder(builder: (context) {
                List<Widget> children = [
                  const BaseAssetsOverviewChartsWidget(),
                  const AssetsOverviewGeoChart(),
                  const CurrencyChartWidget(),
                  const PortfolioTabChartWidget(),
                ];

                return BlocBuilder<TabManager, int>(
                  builder: (context, state) {
                    return children[state];
                  },
                );
              })
            ],
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
