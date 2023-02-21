import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'assets_list_entity.dart';

enum AssetsOverviewType{
  assetType,
  geography,
  currency,
}

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
