import '../../domain/entities/get_asset_class_entity.dart';

class GetAssetClassResponse extends GetAssetClassEntity {
  const GetAssetClassResponse({
    required String assetName,
    required int marketValue,
    required int forexValue,
    required int income,
    required int commision,
    required int total,
    required double changePercentage,
  }) : super(
          assetName: assetName,
          marketValue: marketValue,
          forexValue: forexValue,
          income: income,
          commision: commision,
          total: total,
          changePercentage: changePercentage,
        );

  factory GetAssetClassResponse.fromJson(Map<String, dynamic> json) =>
      GetAssetClassResponse(
        assetName: json["assetName"],
        marketValue: json["marketValue"],
        forexValue: json["forexValue"],
        income: json["income"],
        commision: json["commision"],
        total: json["total"],
        changePercentage: json["changePercentage"].toDouble(),
      );

  static final tResponse = [
    GetAssetClassResponse.fromJson(const {
      "assetName": "Private Equity",
      "marketValue": 10000,
      "forexValue": 100,
      "income": 2000,
      "commision": 100,
      "total": 1200000,
      "changePercentage": 12.12
    })
  ];
}
