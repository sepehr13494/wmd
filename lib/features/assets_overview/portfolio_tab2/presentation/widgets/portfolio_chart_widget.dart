import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/widgets/chart_wrapper_box.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/models/each_asset_model.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/inside_pie_chart.dart';

import '../../../charts/presentation/models/color_title_obj.dart';
import '../../../charts/presentation/widgets/color_with_title_widget.dart';
import '../../../charts/presentation/widgets/constants.dart';
import '../../domain/entities/get_portfolio_allocation_entity.dart';
import '../manager/portfolio_tab2_cubit.dart';

class PortfolioTabChartWidget extends StatelessWidget {
  const PortfolioTabChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChartWrapperBox(
      child: BlocConsumer<PortfolioTab2Cubit, PortfolioTab2State>(
        listener: (context, state) {
          if(state is GetPortfolioAllocationLoaded){
            context.read<PortfolioTab2CubitForTab>().getPortfolioTab(portfolioIds: state.getPortfolioAllocationEntities.map((e) => e.portfolioName).toList());
          }
        },
        builder: (context, state) {
          return state is GetPortfolioAllocationLoaded
              ? Column(
            children: [
              Expanded(
                child: InsidePieChart(
                  eachAssetViewModels: state.getPortfolioAllocationEntities
                      .map(
                        (e) => EachAssetViewModel(
                      color: AssetsOverviewChartsColors.treeMapColors[
                      state.getPortfolioAllocationEntities.indexOf(e)],
                      name: e.portfolioName,
                      price: e.value.convertMoney(),
                      value: e.value.toDouble(),
                      percentage:
                      e.percentage.toStringAsFixedZero(1),
                    ),
                  )
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),
              ColorsWithTitlesWidget(colorTitles: List.generate(state.getPortfolioAllocationEntities.length, (index) {
                GetPortfolioAllocationEntity item = state.getPortfolioAllocationEntities[index];
                return ColorTitleObj(title: item.portfolioName,color: AssetsOverviewChartsColors.treeMapColors[index]);
              }),axisColumnCount: ResponsiveHelper(context: context).isDesktop ? 3 : 2,),
              const SizedBox(height: 16),
            ],
          )
              : const LoadingWidget();
        },
      ),
    );
  }
}
