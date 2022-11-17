import 'dart:convert';
import 'package:wmd/features/add_assets/add_private_debt/domain/entities/private_debt_save_response.dart';

PrivateDebtSaveResponseModel privateDebtFailResponseModelFromJson(String str) =>
    PrivateDebtSaveResponseModel.fromJson(json.decode(str));

String privateDebtSaveResponseModelToJson(PrivateDebtSaveResponseModel data) =>
    json.encode(data.toJson());

class PrivateDebtSaveResponseModel extends PrivateDebtSaveResponse {
  const PrivateDebtSaveResponseModel({
    required String currencyCode,
    required double currencyRate,
    required double startingBalance,
    required double totalNetWorthChange,
    required double totalNetWorth,
  }) : super(
          currencyCode: currencyCode,
          currencyRate: currencyRate,
          startingBalance: startingBalance,
          totalNetWorth: totalNetWorth,
          totalNetWorthChange: totalNetWorthChange,
        );

  factory PrivateDebtSaveResponseModel.fromJson(Map<String, dynamic> json) =>
      PrivateDebtSaveResponseModel(
        currencyCode: json["currencyCode"],
        currencyRate: json["currencyRate"].toDouble(),
        startingBalance: json["startingBalance"],
        totalNetWorthChange: json["totalNetWorthChange"],
        totalNetWorth: json["totalNetWorth"],
      );

  Map<String, dynamic> toJson() => {
        "currencyCode": currencyCode,
        "currencyRate": currencyRate,
        "startingBalance": startingBalance,
        "totalNetWorthChange": totalNetWorthChange,
        "totalNetWorth": totalNetWorth,
      };

  static final tBankSaveResponse = {
    "currencyCode": "TRY",
    "currencyRate": 1.5,
    "startingBalance": 500,
    "totalNetWorthChange": 750,
    "totalNetWorth": 0
  };

  static const tBankSaveResponseModel = PrivateDebtSaveResponseModel(
    currencyCode: "TRY",
    currencyRate: 1.5,
    startingBalance: 500,
    totalNetWorthChange: 750,
    totalNetWorth: 0,
  );
}
