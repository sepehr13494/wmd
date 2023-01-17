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

  static const Map<String, Color> colorsMapPie = {
    AssetTypes.bankAccount: Color(0xff69544B),
    AssetTypes.listedAsset: Color(0xff41765D),
    AssetTypes.privateEquity: Color(0xff8E6B9E),
    AssetTypes.privateDebt: Color(0xff3C4C53),
    AssetTypes.realEstate: Color(0xff44344C),
    AssetTypes.otherAsset: Color(0xff769EA7),
  };

  static String getAssetType(AppLocalizations appLocalizations, String type,{String? category}) {
    switch (type) {
      case AssetTypes.bankAccount:
        return appLocalizations.assetLiabilityForms_assets_bankAccount;
      case AssetTypes.listedAsset:
        String after = " - ";
        if(category != null){
          switch (category.toLowerCase().replaceAll(" ", "")){
            case "equity":
              after += appLocalizations.assetLiabilityForms_forms_listedAssets_inputFields_assetType_options_equity;
              break;
            case "fixedincome":
              after += appLocalizations.assetLiabilityForms_forms_listedAssets_inputFields_assetType_options_fixedIncome;
              break;
            default:
              after += appLocalizations.assetLiabilityForms_forms_others_inputFields_assetType_options_other;
              break;
          }
        }
        return appLocalizations.assetLiabilityForms_assets_listedAssets + after;
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
      case AssetTypes.otherAssets:
        return appLocalizations
            .manage_assetAndLiability_assetAndLiabilityList_others_title;
      default:
        print("wrong type : $type");
        return "Wrong asset type";
    }
  }

  static String getContinentsNames(AppLocalizations appLocalizations,String name){
    switch (name.toLowerCase().replaceAll(" ", "")){
      case "asia":
        return appLocalizations.assets_geography_Asia;
      case "europe":
        return appLocalizations.assets_geography_Asia;
      case "oceania":
        return appLocalizations.assets_geography_Asia;
      case "Oceania":
        return appLocalizations.assets_geography_Asia;
      case "africa":
        return appLocalizations.assets_geography_Asia;
      case "northamerica":
        return appLocalizations.assets_geography_Asia;
      case "southamerica":
        return appLocalizations.assets_geography_Asia;
      default:
        print("wrong continent : $name");
        return appLocalizations.assets_geography_Asia;
    }
  }
}
