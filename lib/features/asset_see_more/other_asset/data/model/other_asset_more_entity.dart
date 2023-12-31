// To parse this JSON data, do
//
//     final realEstateMoreEntity = realEstateMoreEntityFromJson(jsonString);

import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/features/add_assets/core/data/models/country.dart';
import 'package:wmd/features/add_assets/core/data/models/currency.dart';
import 'package:wmd/features/asset_see_more/core/data/models/get_asset_see_more_response.dart';

class OtherAseetMoreEntity extends GetSeeMoreResponse {
  OtherAseetMoreEntity({
    required this.category,
    required this.units,
    required this.acquisitionCost,
    required this.ownerShip,
    this.valuePerUnit,
    required this.currentDayValue,
    required this.name,
    this.wealthManager,
    required this.acquisitionDate,
    required this.valuationDate,
    required this.id,
    required this.type,
    required this.isActive,
    required this.country,
    required this.region,
    required this.currencyCode,
    required this.portfolioContribution,
    required this.holdings,
    required this.yearToDate,
    required this.inceptionToDate,
    required this.asOfDate,
  });

  final String name;
  final String? wealthManager;
  final String category;
  final double units;
  final double acquisitionCost;
  final DateTime? acquisitionDate;
  final DateTime valuationDate;
  final double ownerShip;
  final double? valuePerUnit;
  final double currentDayValue;
  final String id;
  final String type;
  final bool isActive;
  final String country;
  final String region;
  final String currencyCode;
  final double portfolioContribution;
  final double holdings;
  final double yearToDate;
  final double inceptionToDate;
  final DateTime asOfDate;

  factory OtherAseetMoreEntity.fromJson(Map<String, dynamic> json) {
    double? valuePerUnit;
    if (json["valuePerUnit"] != null) {
      final x = (double.tryParse(json["valuePerUnit"].toString()) ?? 0);
      if (x == 0) {
        valuePerUnit = null;
      }
    }
    return OtherAseetMoreEntity(
      name: json["name"],
      acquisitionDate: json["acquisitionDate"] == null
          ? null
          : DateTime.parse(json["acquisitionDate"]),
      valuationDate: DateTime.parse(json["valuationDate"]),
      id: json["id"],
      type: json["type"].toString(),
      isActive: json["isActive"],
      country: json["country"],
      region: json["region"],
      currencyCode: json["currencyCode"],
      portfolioContribution:
          double.tryParse(json["portfolioContribution"].toString()) ?? 0,
      holdings: double.tryParse(json["holdings"].toString()) ?? 0,
      yearToDate: double.tryParse(json["yearToDate"].toString()) ?? 0,
      inceptionToDate: double.tryParse(json["inceptionToDate"].toString()) ?? 0,
      asOfDate: DateTime.parse(json["asOfDate"]),
      wealthManager: json["wealthManager"],
      category: json["category"].toString(),
      units: double.tryParse(json["units"].toString()) ?? 0,
      acquisitionCost: json["acquisitionCost"],
      ownerShip: double.tryParse(json["ownership"].toString()) ?? 0,
      valuePerUnit: json["valuePerUnit"] == null ? null : valuePerUnit,
      currentDayValue: double.tryParse(json["currentDayValue"].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "wealthManager": wealthManager,
        "category": category,
        "units": units,
        "acquisitionCost": acquisitionCost,
        "acquisitionDate":
            acquisitionDate == null ? null : acquisitionDate!.toIso8601String(),
        "valuationDate": valuationDate.toIso8601String(),
        "ownership": ownerShip,
        "valuePerUnit": valuePerUnit,
        "currentDayValue": currentDayValue,
        "id": id,
        "type": type,
        "isActive": isActive,
        "country": country,
        "region": region,
        "currencyCode": currencyCode,
        "portfolioContribution": portfolioContribution,
        "holdings": holdings,
        "yearToDate": yearToDate,
        "inceptionToDate": inceptionToDate,
        "asOfDate": asOfDate.toIso8601String(),
      };

  Map<String, dynamic> toFormJson(context) => {
        "name": name,
        "wealthManager": wealthManager,
        "assetType": category,
        "units": units.toStringAsFixed(0),
        "acquisitionCost": acquisitionCost.convertMoney(),
        "acquisitionDate": acquisitionDate,
        "valuationDate": valuationDate,
        "ownerShip": ownerShip.toStringAsFixedZero(0),
        "valuePerUnit":
            valuePerUnit == null ? null : valuePerUnit!.convertMoney(),
        "currentDayValue": ((currentDayValue * 100) / ownerShip).convertMoney(),
        "id": id,
        "type": type,
        "isActive": isActive,
        "country": Country.getCountryFromString(country, context),
        "region": region,
        "currencyCode": Currency.getCurrencyFromString(currencyCode, context),
        "portfolioContribution": portfolioContribution,
        "holdings": holdings,
        "yearToDate": yearToDate,
        "inceptionToDate": inceptionToDate,
        "asOfDate": asOfDate,
      };
}
