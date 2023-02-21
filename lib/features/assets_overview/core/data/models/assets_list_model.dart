import '../../domain/entities/assets_list_entity.dart';

class AssetListResponse extends AssetList {
  const AssetListResponse({
    required String assetId,
    required String currency,
    required String assetName,
    dynamic subType,
    required double currentValue,
    required double inceptionToDate,
    required double yearToDate,
    required String geography,
    required String type,
  }) : super(
    assetId : assetId,
    currency : currency,
    assetName : assetName,
    subType : subType,
    currentValue : currentValue,
    inceptionToDate : inceptionToDate,
    yearToDate : yearToDate,
    geography : geography,
    type : type,
  );

  factory AssetListResponse.fromJson(Map<String, dynamic> json) => AssetListResponse(
    assetId: json["assetId"] ?? "",
    currency: json["currency"] ?? "",
    assetName: json["assetName"] ?? "",
    subType: json["subType"],
    currentValue: double.tryParse(json["currentValue"].toString()) ?? 0,
    inceptionToDate: double.tryParse(json["inceptionToDate"].toString()) ?? 0,
    yearToDate: double.tryParse(json["yearToDate"].toString()) ?? 0,
    geography: json["geography"] ?? "",
    type: json["type"] ?? "",
  );
}