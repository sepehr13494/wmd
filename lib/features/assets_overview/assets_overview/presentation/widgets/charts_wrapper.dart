import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/base_chart_view.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';

class ChartsWrapper extends AppStatelessWidget {
  const ChartsWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    final time = context.read<MainDashboardCubit>().dateTimeRange;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Allocation by',
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
          length: 3,
          child: Column(
            children: [
              Row(
                children: const [
                  SizedBox(
                    width: 300,
                    child: TabBar(
                      tabs: [
                        Tab(text: "Asset Class"),
                        Tab(text: "Geography"),
                        Tab(text: "Currency"),
                      ],
                      isScrollable: true,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              const Divider(
                height: 0.5,
                thickness: 0.5,
              ),
              AspectRatio(
                aspectRatio:
                    ResponsiveHelper(context: context).isMobile ? 1.6 : 2,
                child: TabBarView(children: [
                  const BaseAssetsOverviewChartsWidget(),
                  Container(),
                  Container(),
                ]),
              )
            ],
          ),
        ),
      ],
    );
  }
}
