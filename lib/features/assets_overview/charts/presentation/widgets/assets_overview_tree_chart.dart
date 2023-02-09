import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';

import '../../domain/entities/get_chart_entity.dart';

class AssetsOverviewTreeChart extends AppStatelessWidget {
  final List<GetChartEntity> getChartEntities;

  const AssetsOverviewTreeChart({Key? key, required this.getChartEntities})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme, AppLocalizations appLocalizations) {
    final List<double> items = [2, 8, 100,34,12,54,97,212,32,200];
    final List<Color> colors = [
      Colors.greenAccent,
      Colors.blue,
      Colors.red,
      Colors.yellow,
      Colors.grey,
      Colors.green,
      Colors.pink,
      Colors.purple,
      Colors.orange,
      Colors.tealAccent,
      Colors.indigo,
      Colors.brown,
      Colors.blueGrey,
    ];
    double sum = 0;
    for(var item in items){
      sum += item;
    }
    double leftover = sum;
    List<double> firstFlexes = [];
    List<double> secondFlexes = [];
    items.sort((a, b) => (b-a).toInt(),);
    print(items);
    for (int i = 0; i < items.length; i++) {
      firstFlexes.add(items[i] / leftover);
      secondFlexes.add((leftover - items[i]) / leftover);
      leftover = leftover - items[i];
    }
    firstFlexes = firstFlexes.reversed.toList();
    secondFlexes = secondFlexes.reversed.toList();
    generateWidget(
        {required Widget child, required double firstFlex, required double secondFlex,required int index}) {
      print("$index   ${(firstFlex * 100).toInt()}   ${(secondFlex*100).toInt()}");
      return LayoutBuilder(
        builder: (context, snap) {
          return RowOrColumn(
            showRow: snap.maxWidth > snap.maxHeight,
            children: [
              Expanded(
                flex: (firstFlex * 100).toInt(),
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  color: colors[index],
                ),
              ),
              secondFlex == 0 ? const SizedBox() : Expanded(
                flex: (secondFlex*100).toInt(),
                child: child,
              )
            ],
          );
        },
      );
    }
    Widget finalWidget = const SizedBox();
    for (int i = 0; i < firstFlexes.length; i++) {
      finalWidget = generateWidget(child: finalWidget,firstFlex: firstFlexes[i],secondFlex: secondFlexes[i],index: i);
    }
    return finalWidget;
  }

}
