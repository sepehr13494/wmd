import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/assets_overview/assets_overview/domain/entities/assets_overview_entity.dart';

import '../assets_overview_inherit.dart';
import 'inside_asset_card_mobile.dart';
import 'inside_asset_card_tablet.dart';

class AssetTypeBaseCard extends StatelessWidget {
  const AssetTypeBaseCard({
    Key? key,
    required this.showMore,
    required this.controller,
  }) : super(key: key);

  final bool showMore;
  final ExpandableController controller;

  @override
  Widget build(BuildContext context) {
    List<AssetList> assetList = AssetsOverviewInherit.of(context).assetList;
    final bool minimum = assetList.length <= 2;
    return Column(
      children: [
        ...List.generate((minimum || showMore) ? assetList.length : 2 , (index) {
          return Card(
            color: index % 2 == 0
                ? null
                : Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkCardColorForDarkTheme
                : AppColors.darkCardColorForLightTheme,
            child: ResponsiveWidget(
                mobile: InsideAssetCardMobile(asset: assetList[index]),
                tablet: InsideAssetCardTablet(asset: assetList[index]),
                desktop: InsideAssetCardTablet(asset: assetList[index])),
          );
        }),
        minimum ? const SizedBox() : InkWell(
          onTap: () {
            controller.toggle();
          },
          child: Card(
            child: SizedBox(
              width: double.maxFinite,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    showMore ? "Show less" : "Show more",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}