import 'package:flutter/material.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AssetsOverviewChartsColors {
  static const List<Color> colors = [
    Color(0xff6C5379),
    Color(0xff5DA683),
    Color(0xff4353D6),
    Color(0xff50747C),
    Color(0xffB99855),
    Color(0xffFFFFFF),
  ];
  static const Map<String, Color> colorsMap = {
    AssetTypes.bankAccount: Color(0xff6C5379),
    AssetTypes.listedAsset: Color(0xff5DA683),
    AssetTypes.privateEquity: Color(0xff4353D6),
    AssetTypes.privateDebt: Color(0xff50747C),
    AssetTypes.realEstate: Color(0xffB99855),
    AssetTypes.otherAsset: Color(0xffFFFFFF),
  };

  static getAssetType(AppLocalizations appLocalizations, String type) {
    switch (type) {
      case AssetTypes.bankAccount:
        return appLocalizations.assetLiabilityForms_assets_bankAccount;
      case AssetTypes.listedAsset:
        return appLocalizations.assetLiabilityForms_assets_listedAssets;
      case AssetTypes.privateEquity:
        return appLocalizations.assetLiabilityForms_assets_privateEquity;
      case AssetTypes.privateDebt:
        return appLocalizations.assetLiabilityForms_assets_privateDebt;
      case AssetTypes.realEstate:
        return appLocalizations
            .manage_assetAndLiability_assetAndLiabilityList_realEstate_title;
      case AssetTypes.otherAsset:
        return appLocalizations
            .manage_assetAndLiability_assetAndLiabilityList_others_title;
      default:
    }
  }
}
