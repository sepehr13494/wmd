import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/assets_overview/assets_overview/domain/entities/assets_overview_entity.dart';

import 'inside_asset_card_mobile.dart';
import 'inside_asset_card_tablet.dart';

class AssetListWidget extends StatefulWidget {
  final List<AssetList> assetList;
  final String type;
  const AssetListWidget({
    Key? key,
    required this.assetList,
    required this.type,
  }) : super(key: key);

  @override
  State<AssetListWidget> createState() => _AssetListWidgetState();
}

class _AssetListWidgetState extends State<AssetListWidget> {
  int count = 0;
  final int initial = 2;
  final int add = 5;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    if (widget.assetList.length > initial) {
      count = initial;
    } else {
      count = widget.assetList.length;
    }
  }

  void loadMore() {
    setState(() {
      if (widget.assetList.length > count + add) {
        count = count + add;
      } else {
        count = widget.assetList.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 2),
      child: Column(
        children: [
          ListView.builder(
            itemCount: count,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = widget.assetList[index];
              return _buildAsset(context, item, index);
            },
          ),
          if (count == widget.assetList.length && count > initial)
            InkWell(
              onTap: () {
                setState(() {
                  init();
                });
              },
              child: Card(
                child: SizedBox(
                  width: double.maxFinite,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        "Show less",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (count < widget.assetList.length)
            InkWell(
              onTap: () {
                loadMore();
              },
              child: Card(
                child: SizedBox(
                  width: double.maxFinite,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        "Show more",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  InkWell _buildAsset(BuildContext context, AssetList item, int index) {
    return InkWell(
      onTap: () {
        context.goNamed(AppRoutes.assetDetailPage,
            queryParams: {'assetId': item.assetId, 'type': widget.type});
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
  }
}