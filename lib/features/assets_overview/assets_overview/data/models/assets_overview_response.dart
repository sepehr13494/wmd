import 'package:wmd/features/assets_overview/assets_overview/domain/entities/assets_overview_entity.dart';

import '../../../core/data/models/assets_list_model.dart';

class AssetsOverviewResponse extends AssetsOverviewEntity {
  const AssetsOverviewResponse({
    required String type,
    required String? assetClassSubType,
    required double totalAmount,
    required List<AssetListResponse> assetList,
    required double yearToDate,
    required double inceptionToDate,
  }) : super(
          type: type,
    subType: assetClassSubType,
          totalAmount: totalAmount,
          assetList: assetList,
          yearToDate: yearToDate,
          inceptionToDate: inceptionToDate,
        );

  factory AssetsOverviewResponse.fromJson(Map<String, dynamic> json) =>
      AssetsOverviewResponse(
        type: json["type"] ?? ".",
        assetClassSubType: json["assetClassSubType"],
        totalAmount: double.tryParse(json["totalAmount"].toString()) ?? 0,
        assetList: List<AssetListResponse>.from(
            json["assetList"].map((x) => AssetListResponse.fromJson(x))),
        yearToDate: double.tryParse(json["yearToDate"].toString()) ?? 0,
        inceptionToDate:
            double.tryParse(json["inceptionToDate"].toString()) ?? 0,
      );

  static const tAssetsOverviewResponse = AssetsOverviewResponse(
    type: "Bank Account",
    assetClassSubType: null,
    totalAmount: 1000000.222,
    assetList: [
      AssetListResponse(
        assetId: "assetId",
        assetName: "assetName",
        currentValue: 1000000,
        inceptionToDate: 10,
        yearToDate: 10,
        geography: "Asia", currency: '',type: ""
      )
    ],
    yearToDate: 10,
    inceptionToDate: 10,
  );

  static final tAssetsOverviewList = [
    tAssetsOverviewResponse
  ];
}

