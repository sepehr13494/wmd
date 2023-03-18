import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/presentation/widgets/shimer_widget.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/shimmer/map_chart_shimmer.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/shimmer/networth_chart_shimmer.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/shimmer/pie_chart_shimmer.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/widgets/performance_table_shimmer.dart';


class MainDashboardShimmer extends AppStatelessWidget {
  const MainDashboardShimmer({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme, AppLocalizations appLocalizations) {
    final bool isMobile = ResponsiveHelper(context: context).isMobile;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerWidget(
            child: Column(
              children: [
                Row(
                  children: [
                    ShimmerContainer(width: 200, height: 30),
                    Spacer(),
                    ShimmerContainer(width: 80, height: 38),
                  ],
                ),
                const SizedBox(height: 24),
                ShimmerContainer(width: double.maxFinite, height: 60),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerContainer(width: 120, height: 20),
                    ShimmerContainer(width: 100, height: 20),
                  ],
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 12),
              RowOrColumn(
                showRow: !isMobile,
                children: List.generate(3, (index) {
                  return ExpandedIf(
                    expanded: !isMobile,
                    child: Card(
                      color: AppColors.shimmerColor,
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: ShimmerWidget(
                              secondColor: true,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 4),
                                  ShimmerContainer(width: 120, height: 14),
                                  const SizedBox(height: 12),
                                  ShimmerContainer(width: 200, height: 20),
                                  const SizedBox(height: 12),
                                  Builder(builder: (context) {
                                    return Row(
                                      children: [
                                        ShimmerContainer(width: 60, height: 12),
                                        const SizedBox(width: 12),
                                        ShimmerContainer(width: 60, height: 12),
                                      ],
                                    );
                                  }),
                                  SizedBox(height: 4),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          SizedBox(height: 24),
          NetWorthChartShimmer(),
          const SizedBox(height: 8),
          ShimmerWidget(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                  appLocalizations
                      .home_label_yourAssets,
                  style:
                  textTheme.titleLarge),
            ),
          ),
          RowOrColumn(
            rowCrossAxisAlignment:
            CrossAxisAlignment.start,
            showRow: !isMobile,
            children: [
              ExpandedIf(
                  expanded: !isMobile,
                  child:
                  const PieChartShimmer()),
              ExpandedIf(
                  expanded: !isMobile,
                  child:
                  const MapChartShimmer()),
            ],
          ),
          Column(
            children: [
              PerformanceTableShimmer(),
            ].map((e) => Padding(padding: const EdgeInsets.symmetric(vertical: 8),child: e,)).toList(),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

}
