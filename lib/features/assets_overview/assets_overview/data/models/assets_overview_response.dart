import 'package:wmd/features/assets_overview/assets_overview/domain/entities/assets_overview_entity.dart';

class AssetsOverviewResponse extends AssetsOverviewEntity {
  const AssetsOverviewResponse({
    required String type,
    required double totalAmount,
    required List<AssetListResponse> assetList,
    required double yearToDate,
    required double inceptionToDate,
  }) : super(
          type: type,
          totalAmount: totalAmount,
          assetList: assetList,
          yearToDate: yearToDate,
          inceptionToDate: inceptionToDate,
        );

  factory AssetsOverviewResponse.fromJson(Map<String, dynamic> json) =>
      AssetsOverviewResponse(
        type: json["type"] ?? "",
        totalAmount: double.tryParse(json["totalAmount"].toString()) ?? 0,
        assetList: List<AssetListResponse>.from(
            json["assetList"].map((x) => AssetListResponse.fromJson(x))),
        yearToDate: double.tryParse(json["yearToDate"].toString()) ?? 0,
        inceptionToDate:
            double.tryParse(json["inceptionToDate"].toString()) ?? 0,
      );

  static const tAssetsOverviewResponse = AssetsOverviewResponse(
    type: "Bank Account",
    totalAmount: 1000000.222,
    assetList: [
      AssetListResponse(
        assetId: "assetId",
        assetName: "assetName",
        currentValue: 1000000,
        inceptionToDate: 10,
        yearToDate: 10,
        geography: "Asia",
      )
    ],
    yearToDate: 10,
    inceptionToDate: 10,
  );

  static final tAssetsOverviewList = [
    tAssetsOverviewResponse
  ];
}

class AssetListResponse extends AssetList {
  const AssetListResponse({
    required String assetId,
    required String assetName,
    required double currentValue,
    required double inceptionToDate,
    required double yearToDate,
    required String geography,
  }) : super(
          assetId: assetId,
          assetName: assetName,
          currentValue: currentValue,
          inceptionToDate: inceptionToDate,
          yearToDate: yearToDate,
          geography: geography,
        );

  factory AssetListResponse.fromJson(Map<String, dynamic> json) =>
      AssetListResponse(
        assetId: json["assetId"] ?? "",
        assetName: json["assetName"] ?? "",
        currentValue: double.tryParse(json["currentValue"].toString()) ?? 0,
        inceptionToDate:
            double.tryParse(json["inceptionToDate"].toString()) ?? 0,
        yearToDate: double.tryParse(json["yearToDate"].toString()) ?? 0,
        geography: json["geography"] ?? "",
      );
}
