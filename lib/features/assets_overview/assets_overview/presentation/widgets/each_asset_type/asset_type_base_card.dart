import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';

import 'each_asset_type.dart';
import 'inside_asset_card_mobile.dart';
import 'inside_asset_card_tablet.dart';

class AssetTypeBaseCard extends StatelessWidget {
  const AssetTypeBaseCard({
    Key? key,
    required this.count,
    required this.showMore,
    required this.controller,
  }) : super(key: key);

  final int count;
  final bool showMore;
  final ExpandableController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(count, (index) {
          return Card(
            color: index % 2 == 0
                ? null
                : Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkCardColorForDarkTheme
                : AppColors.darkCardColorForLightTheme,
            child: const ResponsiveWidget(
                mobile: InsideAssetCardMobile(),
                tablet: InsideAssetCardTablet(),
                desktop: InsideAssetCardTablet()),
          );
        }),
        InkWell(
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