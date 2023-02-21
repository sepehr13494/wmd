import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/assets_overview/assets_overview/domain/entities/assets_overview_entity.dart';

import '../../../../core/domain/entities/assets_list_entity.dart';
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
    String type = AssetsOverviewInherit.of(context).type;
    final bool minimum = assetList.length <= 2;
    return Column(
      children: [
        ...List.generate((minimum || showMore) ? assetList.length : 2, (index) {
          final AssetList item = assetList[index];
          return InkWell(
            onTap: () {
              context.goNamed(AppRoutes.assetDetailPage,
                  queryParams: {'assetId': item.assetId, 'type': type});
            },
            child: Card(
              color: index % 2 == 0
                  ? null
                  : Theme.of(context).brightness == Brightness.dark
                      ? AppColors.darkCardColorForDarkTheme
                      : AppColors.darkCardColorForLightTheme,
              child: ResponsiveWidget(
                  mobile: InsideAssetCardMobile(asset: item),
                  tablet: InsideAssetCardTablet(asset: item),
                  desktop: InsideAssetCardTablet(asset: item)),
            ),
          );
        }),
        minimum
            ? const SizedBox()
            : InkWell(
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
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
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
