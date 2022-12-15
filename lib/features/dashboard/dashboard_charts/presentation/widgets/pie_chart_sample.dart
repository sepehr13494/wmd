import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/widgets/loading_widget.dart';
import 'package:wmd/features/dashboard/dashboard_charts/domain/entities/get_pie_entity.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_charts_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/widgets/base_asset_view.dart';
import 'package:wmd/injection_container.dart';

import '../constants.dart';
import '../models/each_asset_model.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DashboardChartsCubit>()..getPie(),
      child: Builder(builder: (context) {
        return BlocBuilder<DashboardChartsCubit, DashboardChartsState>(
          builder: (context, state) {
            return state is GetPieLoaded
                ? state.getPieEntity.isEmpty ? const SizedBox() : BaseAssetView(
                    title: "Asset Class Allocation",
                    assets: List.generate(
                      state.getPieEntity.length,
                      (index){
                        GetPieEntity pieEntity = state.getPieEntity[index];
                        return EachAssetViewModel(
                          color: DashboardChartsConstants.colors[index],
                          name: pieEntity.name,
                          price: pieEntity.value.convertMoney(addDollar: true),
                          percentage: "${pieEntity.percentage.toStringAsFixed(1)}%",
                        );
                      },
                    ),
                    onMoreTap: () {},
                    child: LayoutBuilder(builder: (context, snap) {
                      final double height = snap.maxWidth * 0.65;
                      final inside = height / 5;
                      return SizedBox(
                        height: height,
                        child: PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = pieTouchResponse
                                      .touchedSection!.touchedSectionIndex;
                                });
                              },
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: inside,
                            sections: showingSections((height - inside) / 4,state.getPieEntity),
                          ),
                        ),
                      );
                    }),
                  )
                : LoadingWidget();
          },
        );
      }),
    );
  }

  List<PieChartSectionData> showingSections(double outside, List<GetPieEntity> getPieEntity) {
    return List.generate(getPieEntity.length, (index) {
      final pieStrokeWidth = outside;
      final isTouched = index == touchedIndex;
      final radius = isTouched ? pieStrokeWidth + 10 : pieStrokeWidth;
      GetPieEntity pieEntity = getPieEntity[index];
      return PieChartSectionData(
        color: DashboardChartsConstants.colors[index],
        value: pieEntity.percentage,
        title: '',
        radius: radius,
      );
    });
  }
}
