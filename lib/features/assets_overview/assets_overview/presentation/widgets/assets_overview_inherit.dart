import 'package:flutter/material.dart';
import 'package:wmd/features/assets_overview/assets_overview/domain/entities/assets_overview_entity.dart';

import '../../../core/domain/entities/assets_list_entity.dart';

class AssetsOverviewInherit extends InheritedWidget {
  const AssetsOverviewInherit({
    super.key,
    this.flexList = const [6, 4, 0, 0, 3],
    this.nonExpandedWidth = 80,
    required this.assetList,
    required this.type,
    required super.child,
  });

  final List<int> flexList;
  final double nonExpandedWidth;
  final List<AssetList> assetList;
  final String type;

  static AssetsOverviewInherit of(BuildContext context) {
    final AssetsOverviewInherit? result =
        context.dependOnInheritedWidgetOfExactType<AssetsOverviewInherit>();
    assert(result != null, 'No ParameterFlex found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AssetsOverviewInherit oldWidget) {
    return (flexList != oldWidget.flexList ||
        nonExpandedWidth != oldWidget.nonExpandedWidth ||
        assetList != oldWidget.assetList);
  }
}
