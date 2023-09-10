import '../../domain/entities/get_asset_class_entity.dart';

class GetAssetClassResponse extends GetAssetClassEntity {
  const GetAssetClassResponse({
    required String assetName,
    double? marketValue,
    double? forexValue,
    double? income,
    double? commission,
    double? total,
    double? changePercentage,
  }) : super(
          assetName: assetName,
          marketValue: marketValue,
          forexValue: forexValue,
          income: income,
          commission: commission,
          total: total,
          changePercentage: changePercentage,
        );

  factory GetAssetClassResponse.fromJson(Map<String, dynamic> json) =>
      GetAssetClassResponse(
        assetName: json["assetName"]??"",
        marketValue: json["marketValue"] == null ? null : double.tryParse((json["marketValue"]??"0").toString())??0,
        forexValue: json["forexValue"] == null ? null : double.tryParse((json["forexValue"]??"0").toString())??0,
        income: json["income"] == null ? null : double.tryParse((json["income"]??"0").toString())??0,
        commission: json["commission"] == null ? null : double.tryParse((json["commission"]??"0").toString())??0,
        total: json["total"] == null ? null : double.tryParse((json["total"]??"0").toString())??0,
        changePercentage: json["changePercentage"] == null ? null : double.tryParse((json["changePercentage"]??"0").toString())??0,
      );

  static final tResponse = [
    GetAssetClassResponse.fromJson(const {
      "assetName": "Private Equity",
      "marketValue": 10000,
      "forexValue": 100,
      "income": 2000,
      "commission": 100,
      "total": 1200000,
      "changePercentage": 12.12
    })
  ];
}
