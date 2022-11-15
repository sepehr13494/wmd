import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/entities/bank_save_response.dart';

BankSaveResponseModel bankSaveResponseModelFromJson(String str) =>
    BankSaveResponseModel.fromJson(json.decode(str));

String bankSaveResponseModelToJson(BankSaveResponseModel data) =>
    json.encode(data.toJson());

class BankSaveResponseModel extends BankSaveResponse {
  const BankSaveResponseModel({
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

  factory BankSaveResponseModel.fromJson(Map<String, dynamic> json) =>
      BankSaveResponseModel(
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

  static const tBankSaveResponseModel = BankSaveResponseModel(
    currencyCode: "TRY",
    currencyRate: 1.5,
    startingBalance: 500,
    totalNetWorthChange: 750,
    totalNetWorth: 0,
  );
}
