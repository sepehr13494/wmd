import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RealEstateType {
  final String name;
  final String value;

  RealEstateType({required this.name, required this.value});

  static List<Map<String, dynamic>> json(context) => [
        {
          "value": "Residential",
          "name": AppLocalizations.of(context)
              .assetLiabilityForms_forms_realEstate_inputFields_typeOfRealEstate_options_residential
        },
        {
          "value": "Commercial",
          "name": AppLocalizations.of(context)
              .assetLiabilityForms_forms_realEstate_inputFields_typeOfRealEstate_options_commercial
        },
        {
          "value": "Land",
          "name": AppLocalizations.of(context)
              .assetLiabilityForms_forms_realEstate_inputFields_typeOfRealEstate_options_land
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

  factory RealEstateType.fromJson(Map<String, dynamic> json) => RealEstateType(
        value: json["value"],
        name: json["name"],
      );

  static List<RealEstateType> realEstateList(context) =>
      json(context).map((e) => RealEstateType.fromJson(e)).toList();
}
