import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtherAssetType {
  final String name;
  final String value;

  OtherAssetType({required this.name, required this.value});

  static List<Map<String, dynamic>> json(context) => [
        {
          "value": "Automobile",
          "name": AppLocalizations.of(context)
              .assetLiabilityForms_forms_others_inputFields_assetType_options_autoMobile
        },
        {
          "value": "Yacht",
          "name": AppLocalizations.of(context)
              .assetLiabilityForms_forms_others_inputFields_assetType_options_yacht
        },
        {
          "value": "PrivateJet",
          "name": AppLocalizations.of(context)
              .assetLiabilityForms_forms_others_inputFields_assetType_options_privateJet
        },
        {
          "value": "Watch",
          "name": AppLocalizations.of(context)
              .assetLiabilityForms_forms_others_inputFields_assetType_options_watch
        },
        {
          "value": "Painting",
          "name": AppLocalizations.of(context)
              .assetLiabilityForms_forms_others_inputFields_assetType_options_painting
        },
        {
          "value": "Jewelry",
          "name": AppLocalizations.of(context)
              .assetLiabilityForms_forms_others_inputFields_assetType_options_jewelry
        },
        {
          "value": "OtherAsset",
          "name": AppLocalizations.of(context)
              .assetLiabilityForms_forms_others_inputFields_assetType_options_other
        },
      ];

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => {
        "value": value,
        "name": name,
      };

  factory OtherAssetType.fromJson(Map<String, dynamic> json) => OtherAssetType(
        value: json["value"],
        name: json["name"],
      );

  static List<OtherAssetType> otherAssetList(context) =>
      json(context).map((e) => OtherAssetType.fromJson(e)).toList();
}
