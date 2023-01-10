import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/base_chart_view.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';

class ChartsWrapper extends AppStatelessWidget {
  const ChartsWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final time = context.read<MainDashboardCubit>().dateTimeRange ??  AppConstants.timeFilter(context).first;
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
              '(${time.key})',
              style: textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 24),
        DefaultTabController(
          length: 1,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 300,
                    child: TabBar(
                      tabs: [
                        Tab(text: appLocalizations.assets_charts_tabs_assetClass),
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
                    ResponsiveHelper(context: context).isMobile ? 1.4 : 1.3,
                child: TabBarView(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ResponsiveHelper(context: context).biggerGap),
                    child: Card(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.darkCardColorForDarkTheme
                          : AppColors.darkCardColorForLightTheme,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: const [
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     ChartPicker(
                            //       value: 0,
                            //       onChange: (value) {},
                            //     ),
                            //   ],
                            // ),
                            Expanded(child: BaseAssetsOverviewChartsWidget()),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Container(),
                  // Container(),
                ]),
              )
            ],
          ),
        ),
      ],
    );
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
    return DropdownButton<int>(
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
    );
  }
}
