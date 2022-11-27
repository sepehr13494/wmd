import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/dot_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/features/assets_overview/assets_overview/domain/entities/assets_overview_entity.dart';

import '../assets_overview_inherit.dart';
import '../add_button.dart';
import '../ytd_itd_widget.dart';
import 'asset_type_base_card.dart';
import 'asset_type_mobile_title.dart';
import 'asset_type_tablet_title.dart';

class EachAssetType extends AppStatelessWidget {
  final AssetsOverviewEntity assetsOverview;
  const EachAssetType({Key? key, required this.assetsOverview}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final responsiveHelper = ResponsiveHelper(context: context);
    bool isMobile = responsiveHelper.isMobile;

    return Column(
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      children: [
                        DotWidget(color: _getAssetColorByType(assetsOverview.type)),
                        const SizedBox(width: 8),
                        Text(_getAssetNameByType(assetsOverview.type), style: textTheme.titleSmall)
                      ],
                    ),
                  ),
                ),
                RowOrColumn(
                  columnCrossAxisAlignment: CrossAxisAlignment.start,
                  showRow: !isMobile,
                  children: [
                    Text(
                      assetsOverview.totalAmount.convertMoney(addDollar: true),
                      style: const TextStyle(fontSize: 28),
                    ),
                    SizedBox(width: responsiveHelper.bigger16Gap, height: 16),
                    YtdItdWidget(ytd: assetsOverview.yearToDate,itd: assetsOverview.inceptionToDate),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 8),
              child: AddButton(onTap: _getAssetOnTapByType(context,assetsOverview.type), addAsset: true),
            ),
          ],
        ),
        AssetsOverviewInherit(
          assetList: assetsOverview.assetList,
          child: Builder(builder: (context) {
            ExpandableController controller = ExpandableController();
            return assetsOverview.assetList.isEmpty ? const SizedBox() : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 12,bottom: 4,right: 4,left: 4),
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
        )
      ],
    );
  }


  String _getAssetNameByType(String type){
    switch (type){
      case "BankAccount":
        return "Bank Account";
      case "PrivateEquity":
        return "Private Equity";
      case "PrivateDebt":
        return "Private Debt";
      case "RealEstate":
        return "Real Estate";
      case "ListedAsset":
        return "Listed Asset";
      case "OtherAssets":
        return "Other Assets";
      default:
        return "";
    }
  }

  Color _getAssetColorByType(String type){
    switch (type){
      case "BankAccount":
        return const Color(0xff6C5379);
      case "PrivateEquity":
        return const Color(0xffB99855);
      case "PrivateDebt":
        return const Color(0xff4353D6);
      case "RealEstate":
        return const Color(0xff5DA683);
      case "ListedAsset":
        return const Color(0xff50747C);
      case "OtherAssets":
        return const Color(0xffC7EA86);
      default:
        return const Color(0xff6C5379);
    }
  }

  void Function() _getAssetOnTapByType(BuildContext context,String type){
    switch (type){
      case "BankAccount":
        return (){
          context.goNamed(AppRoutes.addBankManualPage);
        };
      case "PrivateEquity":
        return (){
          context.goNamed(AppRoutes.addPrivateEquity);
        };
      case "PrivateDebt":
        return (){
          context.goNamed(AppRoutes.addPrivateDebt);
        };
      case "RealEstate":
        return (){
          context.goNamed(AppRoutes.addRealEstate);
        };
      case "ListedAsset":
        return (){
          context.goNamed(AppRoutes.addListedAsset);
        };
      case "OtherAssets":
        return (){
          context.goNamed(AppRoutes.addOther);
        };
      default:
        return (){};
    }
  }
}
