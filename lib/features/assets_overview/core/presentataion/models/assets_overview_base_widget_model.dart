import 'package:flutter/material.dart';
import 'package:wmd/features/assets_overview/core/domain/entities/assets_overview_base_model.dart';

enum AssetsOverviewBaseType {
  assetType,
  geography,
  currency,
  portfolio,
}

class AssetsOverviewBaseWidgetModel {
  final String title;
  final double allocation;
  final Color color;
  final AssetsOverviewBaseType assetsOverviewType;
  final AssetsOverviewBaseModel assetsOverviewBaseModel;

  AssetsOverviewBaseWidgetModel({
    required this.title,
    required this.allocation,
    required this.color,
    required this.assetsOverviewType,
    required this.assetsOverviewBaseModel,
  });
}
