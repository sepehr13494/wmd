import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/charts_cubit.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/charts_widget.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';

class BaseAssetsOverviewChartsWidget extends StatelessWidget {
  const BaseAssetsOverviewChartsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartsCubit, ChartsState>(
      builder: (context, state) {
        return state is GetChartLoaded
            ? Column(
              children: [
                AspectRatio(
          aspectRatio: ResponsiveHelper(context: context).isMobile
                  ? 1.6
                  : 2.2,
                    child: AssetsOverviewCharts(
                        getChartEntities: state.getChartEntities),
                  ),
                Builder(
                  builder: (context) {
                    List<String> items = [
                      "Bank Account",
                      "Real Estate",
                      "Private Equity",
                      "Public Equity",
                      "Private Debt",
                      "Other",
                    ];
                    return Wrap(
                      children: List.generate(items.length, (index) {
                        return Expanded(child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AssetsOverviewChartsColors.colors[index],
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(items[index],style: const TextStyle(fontSize: 10),),
                            ],
                          ),
                        ));
                      }),
                    );
                  }
                )
              ],
            )
            : const LoadingWidget();
      },
    );
  }
}
