import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/assets_overview/portfolio_tab/domain/entities/get_portfolio_tab_entity.dart';
import 'package:wmd/features/assets_overview/portfolio_tab/presentation/manager/portfolio_tab_cubit.dart';
import 'package:wmd/features/assets_overview/portfolio_tab/presentation/manager/portfolio_tab_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/models/each_asset_model.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/inside_pie_chart.dart';

import '../../../charts/presentation/models/color_title_obj.dart';
import '../../../charts/presentation/widgets/color_with_title_widget.dart';
import '../../../charts/presentation/widgets/constants.dart';

class PortfolioTabChartWidget extends StatelessWidget {
  const PortfolioTabChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioTabCubit, PortfolioTabState>(
      builder: (context, state) {
        return state is GetPortfolioTabLoaded
            ? Column(
                children: [
                  Expanded(
                    child: InsidePieChart(
                      eachAssetViewModels: state.assetsOverviewBaseModels
                          .map(
                            (e) => EachAssetViewModel(
                              color: AssetsOverviewChartsColors.treeMapColors[
                                  state.assetsOverviewBaseModels.indexOf(e)],
                              name: e.portfolioName,
                              price: e.totalAmount.convertMoney(),
                              value: e.totalAmount,
                              percentage:
                                  e.allocationPercentage.toStringAsFixedZero(1),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ColorsWithTitlesWidget(colorTitles: List.generate(state.assetsOverviewBaseModels.length, (index) {
                    GetPortfolioTabEntity item = state.assetsOverviewBaseModels[index];
                    return ColorTitleObj(title: item.portfolioName,color: AssetsOverviewChartsColors.treeMapColors[index]);
                  }),axisColumnCount: ResponsiveHelper(context: context).isDesktop ? 3 : 2,),
                  const SizedBox(height: 16),
                ],
              )
            : const LoadingWidget();
      },
    );
  }
}
