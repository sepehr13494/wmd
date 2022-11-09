import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/models/each_asset_model.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/base_asset_view.dart';

import 'Indicator.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return BaseAssetView(
      title: "Asset Class Allocation",
      assets: [
        EachAssetViewModel(color: Colors.purple, name: "Real Estate ", price: "\$1,000,000", percentage: "51.0%"),
        EachAssetViewModel(color: Colors.blueGrey, name: "Private Equity", price: "\$500,000", percentage: "26.0%"),
        EachAssetViewModel(color: Colors.blueGrey.shade200, name: "Cash", price: "\$200,000", percentage: "10.0%"),
        EachAssetViewModel(color: Colors.blueGrey.shade800, name: "Stocks", price: "\$175,000", percentage: "9.0%"),
        EachAssetViewModel(color: Colors.purple.shade800, name: "Commodities", price: "\$50,000", percentage: "2.5%"),
        EachAssetViewModel(color: Colors.purple.shade200, name: "Others", price: "\$25,000", percentage: "1.5%"),
      ],
      onMoreTap: (){},
      child: LayoutBuilder(
        builder: (context,snap) {
          final double height = snap.maxWidth*0.65;
          final inside = height/5;
          return SizedBox(
            height: height,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
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
                sections: showingSections((height-inside)/4),
              ),
            ),
          );
        }
      ),
    );
  }

  List<PieChartSectionData> showingSections(double outside) {
    return List.generate(4, (i) {
      final pieStrokeWidth = outside;
      final isTouched = i == touchedIndex;
      final radius = isTouched ? pieStrokeWidth + 10 : pieStrokeWidth;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '',
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '',
            radius: radius,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '',
            radius: radius,
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '',
            radius: radius,
          );
        default:
          throw Error();
      }
    });
  }
}