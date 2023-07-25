import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/dot_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/widgets/each_asset_type/asset_list_widget.dart';
import 'package:wmd/features/assets_overview/core/presentataion/models/assets_overview_base_widget_model.dart';
import 'package:wmd/features/blurred_widget/presentation/widget/privacy_text.dart';
import '../../../domain/entities/assets_overview_entity.dart';
import '../add_button.dart';
import '../assets_overview_inherit.dart';
import '../ytd_itd_widget.dart';
import 'asset_type_mobile_title.dart';
import 'asset_type_tablet_title.dart';

class EachAssetType extends AppStatelessWidget {
  final AssetsOverviewBaseWidgetModel assetsOverviewBaseWidgetModel;

  const EachAssetType({Key? key, required this.assetsOverviewBaseWidgetModel})
      : super(key: key);

  void Function() _getAssetOnTapByType(BuildContext context, String type) {
    print("type: $type");
    switch (type) {
      case AssetTypes.bankAccount:
        return () {
          context.pushNamed(AppRoutes.addBankManualPage);
        };

      case AssetTypes.privateEquity:
        return () {
          context.pushNamed(AppRoutes.addPrivateEquity);
        };

      case AssetTypes.privateDebt:
        return () {
          context.pushNamed(AppRoutes.addPrivateDebt);
        };

      case AssetTypes.realEstate:
        return () {
          context.pushNamed(AppRoutes.addRealEstate);
        };

      case AssetTypes.listedAssetEquity:
      case AssetTypes.listedAssetFixedIncome:
      case AssetTypes.listedAssetOther:
      case AssetTypes.listedAsset:
        return () {
          context.pushNamed(AppRoutes.addListedAsset);
        };

      case AssetTypes.otherAsset:
        return () {
          context.pushNamed(AppRoutes.addOther);
        };

      default:
        return () {};
    }
  }

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Row(
                              children: [
                                DotWidget(color: assetsOverviewBaseWidgetModel.color),
                                const SizedBox(width: 8),
                                Text(assetsOverviewBaseWidgetModel.title,
                                    style: textTheme.titleMedium)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  assetsOverviewBaseWidgetModel.assetsOverviewType ==
                          AssetsOverviewBaseType.assetType
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: AddButton(
                              onTap: _getAssetOnTapByType(context,
                                  (assetsOverviewBaseWidgetModel.assetsOverviewBaseModel as AssetsOverviewEntity).type),
                              addAsset: !isMobile),
                        )
                      : Expanded(
                          child: Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                children: [
                                  Text(appLocalizations
                                      .home_widget_geography_label_allocation),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${assetsOverviewBaseWidgetModel.allocation.toStringAsFixed(1)} %",
                                    textDirection: TextDirection.ltr,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                ],
              ),
              RowOrColumn(
                columnCrossAxisAlignment: CrossAxisAlignment.start,
                showRow: !isMobile,
                children: [
                  SizedBox(
                    width: !isMobile ? 200 : null,
                    child: PrivacyBlurWidget(
                      child: Text(
                        assetsOverviewBaseWidgetModel
                            .assetsOverviewBaseModel.totalAmount
                            .convertMoney(addDollar: true),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                  SizedBox(width: responsiveHelper.bigger16Gap, height: 16),
                  if (assetsOverviewBaseWidgetModel.assetsOverviewType ==
                      AssetsOverviewBaseType.assetType)
                    YtdItdWidget(
                      ytd: assetsOverviewBaseWidgetModel
                          .assetsOverviewBaseModel.yearToDate,
                      itd: assetsOverviewBaseWidgetModel
                          .assetsOverviewBaseModel.inceptionToDate,
                      showToolTip: false,
                      reversed: true,
                    ),
                ],
              )
            ],
          ),
          if (assetsOverviewBaseWidgetModel
              .assetsOverviewBaseModel.assetList.isNotEmpty)
            AssetsOverviewInherit(
              assetList: assetsOverviewBaseWidgetModel
                  .assetsOverviewBaseModel.assetList,
              assetOverviewBaseType:
                  assetsOverviewBaseWidgetModel.assetsOverviewType,
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
                    key: Key(assetsOverviewBaseWidgetModel.title),
                    assetList: assetsOverviewBaseWidgetModel
                        .assetsOverviewBaseModel.assetList,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
