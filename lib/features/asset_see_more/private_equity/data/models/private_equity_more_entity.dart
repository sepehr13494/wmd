import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/features/add_assets/core/data/models/country.dart';
import 'package:wmd/features/add_assets/core/data/models/currency.dart';
import 'package:wmd/features/asset_see_more/core/data/models/get_asset_see_more_response.dart';

class PrivateEquityMoreEntity extends GetSeeMoreResponse {
  PrivateEquityMoreEntity({
    required this.id,
    required this.type,
    required this.isActive,
    required this.country,
    required this.region,
    required this.currencyCode,
    required this.percentage,
    required this.holdings,
    required this.yearToDate,
    required this.inceptionToDate,
    required this.asOfDate,
    required this.subType,
    required this.investmentName,
    required this.investmentAmount,
    required this.investmentDate,
    required this.wealthManager,
    this.marketValue,
    this.valuationDate,
  });

  final String id;
  final String type;
  final bool isActive;
  final String country;
  final String region;
  final String currencyCode;
  final double percentage;
  final double holdings;
  final double yearToDate;
  final double inceptionToDate;
  final DateTime asOfDate;
  final String subType;
  final String investmentName;
  final double investmentAmount;
  final DateTime investmentDate;
  final String wealthManager;
  final double? marketValue;
  final DateTime? valuationDate;

  factory PrivateEquityMoreEntity.fromJson(Map<String, dynamic> json) =>
      PrivateEquityMoreEntity(
        id: json["id"] ?? "",
        type: json["type"] ?? "",
        isActive: json["isActive"] ?? false,
        country: json["country"] ?? "",
        region: json["region"] ?? "",
        currencyCode: json["currencyCode"] ?? "",
        percentage:
            double.tryParse((json["percentage"] ?? "0").toString()) ?? 0,
        holdings: double.tryParse((json["holdings"] ?? "0").toString()) ?? 0,
        yearToDate:
            double.tryParse((json["yearToDate"] ?? "0").toString()) ?? 0,
        inceptionToDate:
            double.tryParse((json["inceptionToDate"] ?? "0").toString()) ?? 0,
        asOfDate: DateTime.tryParse(json["asOfDate"]) ?? DateTime.now(),
        subType: json["subType"] ?? "",
        investmentName: json["investmentName"] ?? "",
        investmentAmount:
            double.tryParse((json["investmentAmount"] ?? "0").toString()) ?? 0,
        investmentDate:
            DateTime.tryParse(json["investmentDate"]) ?? DateTime.now(),
        wealthManager: json["wealthManager"] ?? "",
        marketValue: json["marketValue"] == null ? null :
            double.tryParse((json["marketValue"] ?? "0").toString()) ?? 0,
        valuationDate: json["valuationDate"] == null ? null :
            DateTime.tryParse(json["valuationDate"]) ?? DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "isActive": isActive,
        "country": country,
        "region": region,
        "currencyCode": currencyCode,
        "percentage": percentage,
        "holdings": holdings,
        "yearToDate": yearToDate,
        "inceptionToDate": inceptionToDate,
        "asOfDate": asOfDate.toIso8601String(),
        "subType": subType,
        "investmentName": investmentName,
        "investmentAmount": investmentAmount,
        "investmentDate": investmentDate.toIso8601String(),
        "wealthManager": wealthManager,
        "marketValue": marketValue,
        "valuationDate": valuationDate == null ? null : valuationDate!.toIso8601String(),
      };

  Map<String, dynamic> toFormJson(context) => {
        "id": id,
        "type": type,
        "isActive": isActive,
        "country": Country.getCountryFromString(country, context),
        "region": region,
        "currencyCode": Currency.getCurrencyFromString(currencyCode, context),
        "percentage": percentage.toString(),
        "holdings": holdings.convertMoney(),
        "yearToDate": yearToDate,
        "inceptionToDate": inceptionToDate,
        "asOfDate": asOfDate,
        "subType": subType,
        "investmentName": investmentName,
        "investmentAmount": investmentAmount.convertMoney(),
        "investmentDate": investmentDate,
        "wealthManager": wealthManager,
        "marketValue": marketValue == null ? null : marketValue!.convertMoney(),
        "valuationDate": valuationDate,
      };
}
