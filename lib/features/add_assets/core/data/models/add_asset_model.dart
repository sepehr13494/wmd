import 'dart:convert';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';

AddAssetModel bankSaveResponseModelFromJson(String str) =>
    AddAssetModel.fromJson(json.decode(str));

String bankSaveResponseModelToJson(AddAssetModel data) =>
    json.encode(data.toJson());

class AddAssetModel extends AddAsset {
  const AddAssetModel({
    required String id,
    required String currencyCode,
    required double currencyRate,
    required double startingBalance,
    required double totalNetWorthChange,
    required double totalNetWorth,
  }) : super(
          id: id,
          currencyCode: currencyCode,
          currencyRate: currencyRate,
          startingBalance: startingBalance,
          totalNetWorth: totalNetWorth,
          totalNetWorthChange: totalNetWorthChange,
        );

  factory AddAssetModel.fromJson(Map<String, dynamic> json) => AddAssetModel(
        id: json["id"],
        currencyCode: json["currencyCode"],
        currencyRate: json["currencyRate"],
        startingBalance: json["startingBalance"],
        totalNetWorthChange: json["totalNetWorthChange"],
        totalNetWorth: json["totalNetWorth"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currencyCode": currencyCode,
        "currencyRate": currencyRate,
        "startingBalance": startingBalance,
        "totalNetWorthChange": totalNetWorthChange,
        "totalNetWorth": totalNetWorth,
      };

  static final tAddAssetResponse = {
    "id": "TRY",
    "currencyCode": "TRY",
    "currencyRate": 1.5,
    "startingBalance": 500.00,
    "totalNetWorthChange": 750.00,
    "totalNetWorth": 0.00
  };

  static const tAddAssetModel = AddAssetModel(
    id: "TRY",
    currencyCode: "TRY",
    currencyRate: 1.5,
    startingBalance: 500.00,
    totalNetWorthChange: 750.00,
    totalNetWorth: 0.00,
  );
}
