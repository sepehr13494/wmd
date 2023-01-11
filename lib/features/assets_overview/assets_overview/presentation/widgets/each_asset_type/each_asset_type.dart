import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/dot_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/assets_overview/assets_overview/domain/entities/assets_overview_entity.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/widgets/each_asset_type/asset_list_widget.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/widgets/each_asset_type/inside_asset_card_mobile.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/widgets/each_asset_type/inside_asset_card_tablet.dart';
import 'package:wmd/injection_container.dart';

import '../../../../charts/presentation/widgets/constants.dart';
import '../assets_overview_inherit.dart';
import '../add_button.dart';
import '../ytd_itd_widget.dart';
import 'asset_type_base_card.dart';
import 'asset_type_mobile_title.dart';
import 'asset_type_tablet_title.dart';

class EachAssetType extends AppStatelessWidget {
  final AssetsOverviewEntity assetsOverview;

  const EachAssetType({Key? key, required this.assetsOverview})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    bool isMobile = responsiveHelper.isMobile;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment:
                isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Row(
                        children: [
                          DotWidget(
                              color: _getAssetColorByType(assetsOverview.type)),
                          const SizedBox(width: 8),
                          Text(
                              AssetsOverviewChartsColors.getAssetType(
                                appLocalizations,
                                _getAssetNameByType(assetsOverview.type)
                                    .replaceAll(" ", ""),
                              ),
                              style: textTheme.titleSmall)
                        ],
                      ),
                    ),
                  ),
                  RowOrColumn(
                    columnCrossAxisAlignment: CrossAxisAlignment.start,
                    showRow: !isMobile,
                    children: [
                      Text(
                        assetsOverview.totalAmount
                            .convertMoney(addDollar: true),
                        style: const TextStyle(fontSize: 28),
                      ),
                      SizedBox(width: responsiveHelper.bigger16Gap, height: 16),
                      YtdItdWidget(
                        ytd: assetsOverview.yearToDate,
                        itd: assetsOverview.inceptionToDate,
                        showToolTip: false,
                      ),
                    ],
                  )
                ],
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 4, bottom: 8),
              //   child: AddButton(
              //       onTap: _getAssetOnTapByType(context, assetsOverview.type),
              //       addAsset: true),
              // ),
            ],
          ),
          if (assetsOverview.assetList.isNotEmpty)
            AssetsOverviewInherit(
              assetList: assetsOverview.assetList,
              type: assetsOverview.type,
              child: Column(
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.only(top: 12, bottom: 4, right: 4, left: 4),
                    child: ResponsiveWidget(
                      mobile: AssetTypeMobileTableTitle(),
                      tablet: AssetTypeTabletTableTitle(),
                      desktop: AssetTypeTabletTableTitle(),
                    ),
                  ),
                  AssetListWidget(
                    assetList: assetsOverview.assetList,
                    type: assetsOverview.type,
                  ),
                ],
              ),
            ),
          /*AssetsOverviewInherit(
            assetList: assetsOverview.assetList,
            type: assetsOverview.type,
            child: Builder(builder: (context) {
              ExpandableController controller = ExpandableController();
              return assetsOverview.assetList.isEmpty
                  ? const SizedBox()
                  : Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 12, bottom: 4, right: 4, left: 4),
                          child: ResponsiveWidget(
                            mobile: AssetTypeMobileTableTitle(),
                            tablet: AssetTypeTabletTableTitle(),
                            desktop: AssetTypeTabletTableTitle(),
                          ),
                        ),
                        ExpandablePanel(
                          collapsed: AssetTypeBaseCard(
                              showMore: false, controller: controller),
                          expanded: AssetTypeBaseCard(
                              showMore: true, controller: controller),
                          controller: controller,
                        )
                      ],
                    );
            }),
          )*/
        ],
      ),
    );
  }

  String _getAssetNameByType(String type) {
    switch (type) {
      case AssetTypes.bankAccount:
        return "Bank Account";
      case AssetTypes.privateEquity:
        return "Private Equity";
      case AssetTypes.privateDebt:
        return "Private Debt";
      case AssetTypes.realEstate:
        return "Real Estate";
      case AssetTypes.listedAsset:
        return "Listed Asset";
      case AssetTypes.otherAsset:
        return "Other Assets";
      default:
        return "";
    }
  }

  Color _getAssetColorByType(String type) {
    switch (type) {
      case AssetTypes.bankAccount:
        return AssetsOverviewChartsColors.colors[0];
      case AssetTypes.listedAsset:
        return AssetsOverviewChartsColors.colors[1];
      case AssetTypes.privateEquity:
        return AssetsOverviewChartsColors.colors[2];
      case AssetTypes.privateDebt:
        return AssetsOverviewChartsColors.colors[3];
      case AssetTypes.realEstate:
        return AssetsOverviewChartsColors.colors[4];
      case AssetTypes.otherAsset:
        return AssetsOverviewChartsColors.colors[5];
      default:
        return AssetsOverviewChartsColors.colors[0];
    }
  }

  void Function() _getAssetOnTapByType(BuildContext context, String type) {
    switch (type) {
      case AssetTypes.bankAccount:
        return () {
          context.goNamed(AppRoutes.addBankManualPage);
        };
      case AssetTypes.privateEquity:
        return () {
          context.goNamed(AppRoutes.addPrivateEquity);
        };
      case AssetTypes.privateDebt:
        return () {
          context.goNamed(AppRoutes.addPrivateDebt);
        };
      case AssetTypes.realEstate:
        return () {
          context.goNamed(AppRoutes.addRealEstate);
        };
      case AssetTypes.listedAsset:
        return () {
          context.goNamed(AppRoutes.addListedAsset);
        };
      case AssetTypes.otherAsset:
        return () {
          context.goNamed(AppRoutes.addOther);
        };
      default:
        return () {};
    }
  }
}
