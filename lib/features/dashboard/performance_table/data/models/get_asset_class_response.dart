import '../../domain/entities/get_asset_class_entity.dart';

class GetAssetClassResponse extends GetAssetClassEntity {
  const GetAssetClassResponse({
    required String assetName,
    required double marketValue,
    required double forexValue,
    required double income,
    required double commision,
    required double total,
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
        assetName: json["assetName"]??"",
        marketValue: double.tryParse((json["marketValue"]??"0").toString())??0,
        forexValue: double.tryParse((json["forexValue"]??"0").toString())??0,
        income: double.tryParse((json["income"]??"0").toString())??0,
        commision: double.tryParse((json["commision"]??"0").toString())??0,
        total: double.tryParse((json["total"]??"0").toString())??0,
        changePercentage: double.tryParse((json["changePercentage"]??"0").toString())??0,
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
