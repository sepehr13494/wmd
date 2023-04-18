import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/features/add_assets/core/data/models/country.dart';
import 'package:wmd/features/add_assets/core/data/models/currency.dart';
import 'package:wmd/features/asset_see_more/core/data/models/get_asset_see_more_response.dart';

class RealEstateMoreEntity extends GetSeeMoreResponse {
  RealEstateMoreEntity({
    required this.name,
    required this.realEstateType,
    required this.address,
    required this.noOfUnits,
    required this.acquisitionCostPerUnit,
    required this.acquisitionDate,
    required this.ownershipPercentage,
    required this.marketValue,
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
  final String realEstateType;
  final String address;
  final double noOfUnits;
  final double acquisitionCostPerUnit;
  final DateTime acquisitionDate;
  final double ownershipPercentage;
  final double marketValue;
  final DateTime valuationDate;
  final String id;
  final double type;
  final bool isActive;
  final String country;
  final String region;
  final String currencyCode;
  final double portfolioContribution;
  final double holdings;
  final double yearToDate;
  final double inceptionToDate;
  final DateTime asOfDate;

  factory RealEstateMoreEntity.fromJson(Map<String, dynamic> json) =>
      RealEstateMoreEntity(
        name: json["name"],
        realEstateType: json["realEstateType"],
        address: json["address"],
        noOfUnits: double.tryParse(json["noOfUnits"].toString()) ?? 0,
        acquisitionCostPerUnit:
            double.tryParse(json["acquisitionCostPerUnit"].toString()) ?? 0,
        acquisitionDate: DateTime.parse(json["acquisitionDate"]),
        ownershipPercentage:
            double.tryParse(json["ownershipPercentage"].toString()) ?? 0,
        marketValue: double.tryParse(json["marketValue"].toString()) ?? 0,
        valuationDate: DateTime.parse(json["valuationDate"]),
        id: json["id"],
        type: double.tryParse(json["type"].toString()) ?? 0,
        isActive: json["isActive"],
        country: json["country"],
        region: json["region"],
        currencyCode: json["currencyCode"],
        portfolioContribution:
            double.tryParse(json["portfolioContribution"].toString()) ?? 0,
        holdings: double.tryParse(json["holdings"].toString()) ?? 0,
        yearToDate: double.tryParse(json["yearToDate"].toString()) ?? 0,
        inceptionToDate:
            double.tryParse(json["inceptionToDate"].toString()) ?? 0,
        asOfDate: DateTime.parse(json["asOfDate"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "realEstateType": realEstateType,
        "address": address,
        "noOfUnits": noOfUnits,
        "acquisitionCostPerUnit": acquisitionCostPerUnit,
        "acquisitionDate": acquisitionDate.toIso8601String(),
        "ownershipPercentage": ownershipPercentage,
        "marketValue": marketValue,
        "valuationDate": valuationDate.toIso8601String(),
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

  Map<String, dynamic> toFormJson() => {
    "name": name,
    "realEstateType": realEstateType,
    "address": address,
    "noOfUnits": noOfUnits.toStringAsFixed(0),
    "acquisitionCostPerUnit": acquisitionCostPerUnit.convertMoney(),
    "acquisitionDate": acquisitionDate,
    "ownershipPercentage": ownershipPercentage.toString(),
    "marketValue": marketValue.convertMoney(),
    "valuationDate": valuationDate,
    "id": id,
    "type": type,
    "isActive": isActive,
    "country": Country.getCountryFromString(country),
    "region": region,
    "currencyCode": Currency.getCurrencyFromString(currencyCode),
    "portfolioContribution": portfolioContribution,
    "holdings": holdings,
    "yearToDate": yearToDate,
    "inceptionToDate": inceptionToDate,
    "asOfDate": asOfDate,
  };
}
