import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/base_tree_chart_widget.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';

import '../../domain/entities/get_chart_entity.dart';
import 'base_tree_chart_widget2.dart';

class AssetTreeChartObj extends TreeChartObj{
  final Color color;
  final String type;
  final List<InsideWidget> inside;

  AssetTreeChartObj({required double value,required this.color,required this.type,required this.inside}) : super(value: value);

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
    List<AssetTreeChartObj> realItems = [];
    realItems.add(AssetTreeChartObj(
      value: getChartEntities.map((e) => e.bankAccount).reduce((a, b) => a + b),
      color: AssetsOverviewChartsColors.colorsMap[AssetTypes.bankAccount] ??
          Colors.brown,
      type: AssetTypes.bankAccount,
      inside: getChartEntities.map((e) {
        return InsideWidget(date: e.date, value: e.bankAccount);
      }).toList(),
    ));
    realItems.add(AssetTreeChartObj(
      value:
          getChartEntities.map((e) => e.privateEquity).reduce((a, b) => a + b),
      color: AssetsOverviewChartsColors.colorsMap[AssetTypes.privateEquity] ??
          Colors.brown,
      type: AssetTypes.privateEquity,
      inside: getChartEntities.map((e) {
        return InsideWidget(date: e.date, value: e.privateEquity);
      }).toList(),
    ));
    realItems.add(AssetTreeChartObj(
      value: getChartEntities.map((e) => e.privateDebt).reduce((a, b) => a + b),
      color: AssetsOverviewChartsColors.colorsMap[AssetTypes.privateDebt] ??
          Colors.brown,
      type: AssetTypes.privateDebt,
      inside: getChartEntities.map((e) {
        return InsideWidget(date: e.date, value: e.privateDebt);
      }).toList(),
    ));
    realItems.add(AssetTreeChartObj(
      value: getChartEntities.map((e) => e.realEstate).reduce((a, b) => a + b),
      color: AssetsOverviewChartsColors.colorsMap[AssetTypes.realEstate] ??
          Colors.brown,
      type: AssetTypes.realEstate,
      inside: getChartEntities.map((e) {
        return InsideWidget(date: e.date, value: e.realEstate);
      }).toList(),
    ));
    realItems.add(AssetTreeChartObj(
      value: getChartEntities
          .map((e) => e.listedAssetEquity)
          .reduce((a, b) => a + b),
      color:
          AssetsOverviewChartsColors.colorsMap[AssetTypes.listedAssetEquity] ??
              Colors.brown,
      type: AssetTypes.listedAssetEquity,
      inside: getChartEntities.map((e) {
        return InsideWidget(date: e.date, value: e.listedAssetEquity);
      }).toList(),
    ));
    realItems.add(AssetTreeChartObj(
      value: getChartEntities
          .map((e) => e.listedAssetFixedIncome)
          .reduce((a, b) => a + b),
      color: AssetsOverviewChartsColors
              .colorsMap[AssetTypes.listedAssetFixedIncome] ??
          Colors.brown,
      type: AssetTypes.listedAssetFixedIncome,
      inside: getChartEntities.map((e) {
        return InsideWidget(date: e.date, value: e.listedAssetFixedIncome);
      }).toList(),
    ));
    realItems.add(AssetTreeChartObj(
      value: getChartEntities
          .map((e) => e.listedAssetOther)
          .reduce((a, b) => a + b),
      color:
          AssetsOverviewChartsColors.colorsMap[AssetTypes.listedAssetOther] ??
              Colors.brown,
      type: AssetTypes.listedAssetOther,
      inside: getChartEntities.map((e) {
        return InsideWidget(date: e.date, value: e.listedAssetOther);
      }).toList(),
    ));
    realItems.add(AssetTreeChartObj(
      value: getChartEntities.map((e) => e.others).reduce((a, b) => a + b),
      color: AssetsOverviewChartsColors.colorsMap[AssetTypes.otherAsset] ??
          Colors.brown,
      type: AssetTypes.otherAsset,
      inside: getChartEntities.map((e) {
        return InsideWidget(date: e.date, value: e.others);
      }).toList(),
    ));
    realItems.removeWhere((element) => element.value==0);
    return Column(
      children: [
        Expanded(
          child: BaseTreeChartWidget2(treeChartObjs: realItems, itemBuilder: (AssetTreeChartObj flexItem,itemIndex){
            return Container(
              color: flexItem.color,
              child: RowOrColumn(
                showRow: false,
                children: List.generate(
                    flexItem.inside.length, (index) {
                  final item = flexItem.inside[index];
                  return Expanded(
                    flex: item.value.ceil(),
                    child: Align(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Tooltip(
                              triggerMode: TooltipTriggerMode.tap,
                              message:
                              "${item.date}\n${AssetsOverviewChartsColors.getAssetType(appLocalizations, flexItem.type)}",
                              child: Padding(
                                padding:
                                const EdgeInsets.all(2),
                                child: Align(
                                  alignment:
                                  AlignmentDirectional
                                      .topStart,
                                  child: LayoutBuilder(
                                    builder: (context,snap) {
                                      return SizedBox(
                                        width: snap.maxWidth > 50 ? 50 : snap.maxWidth,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Align(
                                            alignment:
                                            AlignmentDirectional
                                                .topStart,
                                            child: Text(
                                                item.date /*\n${AssetsOverviewChartsColors.getAssetType(appLocalizations, flexItem.type)}*/),
                                          ),
                                        ),
                                      );
                                    }
                                  ),
                                ),
                              ),
                            ),
                          ),
                          index == flexItem.inside.length - 1
                              ? const SizedBox()
                              : Divider(
                            color: textTheme
                                .bodyMedium!.color!,
                            height: 1,
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            );
          }),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
