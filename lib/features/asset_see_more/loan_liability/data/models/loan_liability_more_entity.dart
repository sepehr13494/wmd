// To parse this JSON data, do
//
//     final realEstateMoreEntity = realEstateMoreEntityFromJson(jsonString);

import 'package:wmd/features/asset_see_more/core/data/models/get_asset_see_more_response.dart';

class LoanLiabilityMoreEntity extends GetSeeMoreResponse {
  LoanLiabilityMoreEntity({
    this.bankName,
    this.collateral,
    this.endDate,
    this.startDate,
    this.insurance,
    required this.isActive,
    required this.loanAmountOutstanding,
    required this.loanAmountSanctioned,
    required this.loanName,
    required this.loanType,
    this.monthlyPayment,
    required this.id,
    required this.type,
    this.rate,
  });

  final String? bankName;
  final String? collateral;
  final DateTime? endDate;
  final DateTime? startDate;
  final String? insurance;
  final bool isActive;
  final double loanAmountOutstanding;
  final double loanAmountSanctioned;
  final String loanName;
  final String loanType;
  final double? monthlyPayment;
  final String id;
  final String type;
  final double? rate;

  factory LoanLiabilityMoreEntity.fromJson(Map<String, dynamic> json) =>
      LoanLiabilityMoreEntity(
        bankName: json["bankName"],
        collateral: json["collateral"],
        endDate: json["endDate"] != null
            ? DateTime.parse(json["endDate"])
            : json["endDate"],
        startDate: json["startDate"] != null
            ? DateTime.parse(json["startDate"])
            : json["startDate"],
        insurance: json["insurance"],
        isActive: json["isActive"],
        loanAmountOutstanding:
            double.tryParse(json["loanAmountOutstanding"].toString()) ?? 0,
        loanAmountSanctioned:
            double.tryParse(json["loanAmountSanctioned"].toString()) ?? 0,
        loanName: json["loanName"],
        loanType: json["loanType"],
        monthlyPayment: double.tryParse(json["holdings"].toString()) ?? 0,
        id: json["id"],
        type: json["type"],
        rate: double.tryParse(json["rate"].toString()) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "bankName": bankName,
        "collateral": collateral,
        "endDate": endDate,
        "startDate": startDate,
        "insurance": insurance,
        "isActive": isActive,
        "loanAmountOutstanding": loanAmountOutstanding,
        "loanAmountSanctioned": loanAmountSanctioned,
        "loanName": loanName,
        "loanType": loanType,
        "monthlyPayment": monthlyPayment,
        "id": id,
        "type": type,
        "rate": rate,
      };
}
