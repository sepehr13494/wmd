import 'package:equatable/equatable.dart';

import 'assets_list_entity.dart';

abstract class AssetsOverviewBaseModel extends Equatable {
  final double totalAmount;
  final List<AssetList> assetList;
  final double yearToDate;
  final double inceptionToDate;

  const AssetsOverviewBaseModel({
    required this.totalAmount,
    required this.assetList,
    required this.yearToDate,
    required this.inceptionToDate,
  });
}
