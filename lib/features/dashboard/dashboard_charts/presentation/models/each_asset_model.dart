import 'package:flutter/material.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/features/assets_overview/charts/presentation/widgets/constants.dart';
import 'package:wmd/features/dashboard/dashboard_charts/domain/entities/get_pie_entity.dart';

class EachAssetViewModel {
  final Color? color;
  final String name;
  final String price;
  final double value;
  final String percentage;

  EachAssetViewModel({
    this.color,
    required this.name,
    required this.price,
    required this.value,
    required this.percentage,
  });

  factory EachAssetViewModel.fromPieEntity(GetPieEntity e,appLocalizations) =>
      EachAssetViewModel(
        color: AssetsOverviewChartsColors.colorsMapPie[e.name] ??
            Colors.brown,
        name:  AssetsOverviewChartsColors.getAssetType(
            appLocalizations, e.name),
        price:  e.value.convertMoney(),
        value:  e.value,
        percentage:  e.percentage.toStringAsFixedZero(1),
      );
}
