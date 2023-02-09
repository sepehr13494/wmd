import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';

import '../../domain/entities/get_chart_entity.dart';

class TreeChartObj extends Equatable{
  final double value;
  final Color color;
  final String type;
  final List<InsideWidget> inside;

  const TreeChartObj({
    required this.value,
    required this.color,
    required this.type,
    required this.inside,
  });

  @override
  List<Object?> get props => [type];
}

class InsideWidget {
  final String date;
  final double value;

  InsideWidget({
    required this.date,
    required this.value,
  });
}

class AssetsOverviewTreeChart extends AppStatelessWidget {
  final List<GetChartEntity> getChartEntities;

  const AssetsOverviewTreeChart({Key? key, required this.getChartEntities})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    List<TreeChartObj> realItems = [];
    realItems.add(TreeChartObj(
      value: getChartEntities.map((e) => e.bankAccount).reduce((a, b) => a + b),
      color: AssetsOverviewChartsColors.colorsMap[AssetTypes.bankAccount]??Colors.brown,
      type: AssetTypes.bankAccount,
      inside: getChartEntities.map((e) {
        return InsideWidget(date: e.date, value: e.bankAccount);
      }).toList(),
    ));
    realItems.add(TreeChartObj(
      value: getChartEntities.map((e) => e.privateEquity).reduce((a, b) => a + b),
      color: AssetsOverviewChartsColors.colorsMap[AssetTypes.privateEquity]??Colors.brown,
      type: AssetTypes.privateEquity,
      inside: getChartEntities.map((e) {
        return InsideWidget(date: e.date, value: e.privateEquity);
      }).toList(),
    ));
    realItems.add(TreeChartObj(
      value: getChartEntities.map((e) => e.privateDebt).reduce((a, b) => a + b),
      color: AssetsOverviewChartsColors.colorsMap[AssetTypes.privateDebt]??Colors.brown,
      type: AssetTypes.privateDebt,
      inside: getChartEntities.map((e) {
        return InsideWidget(date: e.date, value: e.privateDebt);
      }).toList(),
    ));
    realItems.add(TreeChartObj(
      value: getChartEntities.map((e) => e.realEstate).reduce((a, b) => a + b),
      color: AssetsOverviewChartsColors.colorsMap[AssetTypes.realEstate]??Colors.brown,
      type: AssetTypes.realEstate,
      inside: getChartEntities.map((e) {
        return InsideWidget(date: e.date, value: e.realEstate);
      }).toList(),
    ));
    realItems.add(TreeChartObj(
      value: getChartEntities.map((e) => e.listedAssetEquity).reduce((a, b) => a + b),
      color: AssetsOverviewChartsColors.colorsMap[AssetTypes.listedAssetEquity]??Colors.brown,
      type: AssetTypes.listedAssetEquity,
      inside: getChartEntities.map((e) {
        return InsideWidget(date: e.date, value: e.listedAssetEquity);
      }).toList(),
    ));
    realItems.add(TreeChartObj(
      value: getChartEntities.map((e) => e.listedAssetFixedIncome).reduce((a, b) => a + b),
      color: AssetsOverviewChartsColors.colorsMap[AssetTypes.listedAssetFixedIncome]??Colors.brown,
      type: AssetTypes.listedAssetFixedIncome,
      inside: getChartEntities.map((e) {
        return InsideWidget(date: e.date, value: e.listedAssetFixedIncome);
      }).toList(),
    ));
    realItems.add(TreeChartObj(
      value: getChartEntities.map((e) => e.listedAssetOther).reduce((a, b) => a + b),
      color: AssetsOverviewChartsColors.colorsMap[AssetTypes.listedAssetOther]??Colors.brown,
      type: AssetTypes.listedAssetOther,
      inside: getChartEntities.map((e) {
        return InsideWidget(date: e.date, value: e.listedAssetOther);
      }).toList(),
    ));
    realItems.add(TreeChartObj(
      value: getChartEntities.map((e) => e.others).reduce((a, b) => a + b),
      color: AssetsOverviewChartsColors.colorsMap[AssetTypes.otherAsset]??Colors.brown,
      type: AssetTypes.otherAsset,
      inside: getChartEntities.map((e) {
        return InsideWidget(date: e.date, value: e.others);
      }).toList(),
    ));
    realItems.sort((a, b) => (b.value - a.value).toInt(),);
    final List<double> items = realItems.map((e) => e.value).toList();
    double sum = items.reduce((a, b) => a + b);
    double leftover = sum;
    List<double> firstFlexes = [];
    List<double> secondFlexes = [];
    items.sort(
      (a, b) => (b - a).toInt(),
    );
    print(items);
    for (int i = 0; i < items.length; i++) {
      print("before leftover $leftover");
      firstFlexes.add(items[i] / leftover);
      secondFlexes.add((leftover - items[i]) / leftover);
      leftover = (leftover - items[i]) < 1 ? 1 : (leftover - items[i]);
      print(items[i]);
      print("after leftover $leftover");
    }
    firstFlexes = firstFlexes.reversed.toList();
    secondFlexes = secondFlexes.reversed.toList();
    generateWidget(
        {required Widget child,
        required double firstFlex,
        required double secondFlex,
        required TreeChartObj treeChartObj}) {
      print(
          "$treeChartObj   ${(firstFlex * sum).ceil()}   ${(secondFlex * sum).ceil()}");
      return LayoutBuilder(
        builder: (context, snap) {
          return RowOrColumn(
            showRow: snap.maxWidth > snap.maxHeight,
            children: [
              firstFlex == 0 ? const SizedBox() : Expanded(
                flex: (firstFlex * sum).ceil(),
                child: Tooltip(
                  message: treeChartObj.type.toString(),
                  child: Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    color: treeChartObj.color,
                  ),
                ),
              ),
              (secondFlex == 0 || firstFlex == 0)
                  ? const SizedBox()
                  : Expanded(
                      flex: (secondFlex * sum).ceil(),
                      child: child,
                    )
            ],
          );
        },
      );
    }

    Widget finalWidget = const SizedBox();
    for (int i = 0; i < firstFlexes.length; i++) {
      finalWidget = generateWidget(
          child: finalWidget,
          firstFlex: firstFlexes[i],
          secondFlex: secondFlexes[i],
          treeChartObj: realItems[realItems.length - 1 - i]);
    }
    return Column(
      children: [
        Expanded(child: finalWidget),
        const SizedBox(height: 12),
      ],
    );
  }
}
