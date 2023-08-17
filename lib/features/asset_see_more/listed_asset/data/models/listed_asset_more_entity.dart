import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/features/add_assets/core/data/models/country.dart';
import 'package:wmd/features/add_assets/core/data/models/currency.dart';
import 'package:wmd/features/add_assets/core/data/models/listed_security_name.dart';

import '../../../core/data/models/get_asset_see_more_response.dart';

class ListedAssetMoreEntity extends GetSeeMoreResponse {
  ListedAssetMoreEntity({
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
    required this.securityName,
    required this.securityShortName,
    required this.tradedExchange,
    required this.brokerName,
    required this.isin,
    required this.category,
    required this.investmentDate,
    required this.marketValue,
    required this.quantity,
    required this.totalCost,
    required this.couponRate,
    required this.maturityDate,
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
  final String securityName;
  final String securityShortName;
  final String tradedExchange;
  final String brokerName;
  final String isin;
  final String category;
  final DateTime investmentDate;
  final double marketValue;
  final double quantity;
  final double totalCost;
  final double? couponRate;
  final DateTime? maturityDate;

  factory ListedAssetMoreEntity.fromJson(Map<String, dynamic> json) =>
      ListedAssetMoreEntity(
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
        securityName: json["securityName"] ?? "",
        securityShortName: json["securityShortName"] ?? "",
        tradedExchange: json["tradedExchange"] ?? "",
        brokerName: json["brokerName"] ?? "",
        isin: json["isin"] ?? "",
        category: json["category"] ?? "",
        investmentDate:
            DateTime.tryParse(json["investmentDate"]) ?? DateTime.now(),
        marketValue:
            double.tryParse((json["marketValue"] ?? "0").toString()) ?? 0,
        quantity: double.tryParse((json["quantity"] ?? "0").toString()) ?? 0,
        totalCost: double.tryParse((json["totalCost"] ?? "0").toString()) ?? 0,
        couponRate:
            double.tryParse((json["couponRate"] ?? "0").toString()) ?? 0,
        maturityDate: json["maturityDate"] == null
            ? null
            : (DateTime.tryParse(json["maturityDate"]) ?? DateTime.now()),
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
        "securityName": securityName,
        "securityShortName": securityShortName,
        "tradedExchange": tradedExchange,
        "brokerName": brokerName,
        "isin": isin,
        "category": category,
        "investmentDate": investmentDate.toIso8601String(),
        "marketValue": marketValue,
        "quantity": quantity,
        "totalCost": totalCost,
        "couponRate": couponRate,
        "maturityDate": maturityDate,
      };

  Map<String, dynamic> toFormJson(
      ListedSecurityName listedSecurityName, context) {
    return {
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
      "securityName": securityName,
      "securityShortName": securityShortName,
      "tradedExchange": tradedExchange,
      "brokerName": brokerName,
      "isin": isin,
      "category": category,
      "investmentDate": investmentDate,
      "marketValue": marketValue.convertMoney(),
      "quantity": quantity.convertMoney(),
      "totalCost": totalCost.convertMoney(),
      "couponRate": couponRate.toString(),
      "maturityDate": maturityDate,
      "name": listedSecurityName,
    };
  }
}
