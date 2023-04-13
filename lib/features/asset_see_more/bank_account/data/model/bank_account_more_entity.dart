// To parse this JSON data, do
//
//     final realEstateMoreEntity = realEstateMoreEntityFromJson(jsonString);

import 'package:wmd/features/asset_see_more/core/data/models/get_asset_see_more_response.dart';

class BankAccountMoreEntity extends GetSeeMoreResponse {
  BankAccountMoreEntity({
    required this.bankName,
    required this.description,
    required this.accountType,
    required this.currentBalance,
    required this.isJointAccount,
    required this.noOfCoOwners,
    required this.ownershipPercentage,
    required this.interestRate,
    this.startDate,
    this.endDate,
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
    this.subType,
  });

  final String bankName;
  final String description;
  final String accountType;
  final double currentBalance;
  final bool isJointAccount;
  final int noOfCoOwners;
  final double ownershipPercentage;
  final double interestRate;
  final DateTime? startDate;
  final DateTime? endDate;
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
  final String? subType;

  factory BankAccountMoreEntity.fromJson(Map<String, dynamic> json) =>
      BankAccountMoreEntity(
        bankName: json["bankName"],
        description: json["description"],
        type: json["type"],
        id: json["id"],
        accountType: json["accountType"],
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
        currentBalance: double.tryParse(json["currentBalance"].toString()) ?? 0,
        interestRate: double.tryParse(json["interestRate"].toString()) ?? 0,
        isJointAccount: json["isJointAccount"],
        noOfCoOwners: json["noOfCoOwners"],
        ownershipPercentage:
            double.tryParse(json["ownershipPercentage"].toString()) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "bankName": bankName,
        "description": description,
        "accountType": accountType,
        "currentBalance": currentBalance,
        "isJointAccount": isJointAccount,
        "noOfCoOwners": noOfCoOwners,
        "ownershipPercentage": ownershipPercentage,
        "interestRate": interestRate,
        "startDate": startDate,
        "endDate": endDate,
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
        "subType": subType,
      };

  Map<String, dynamic> toFormJson() => {
    "bankName": bankName,
    "description": description,
    "accountType": accountType,
    "currentBalance": currentBalance,
    "isJointAccount": isJointAccount,
    "noOfCoOwners": noOfCoOwners,
    "ownershipPercentage": ownershipPercentage,
    "interestRate": interestRate,
    "startDate": startDate,
    "endDate": endDate,
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
    "subType": subType,
  };
}
