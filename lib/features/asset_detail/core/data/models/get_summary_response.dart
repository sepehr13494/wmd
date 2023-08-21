import 'package:wmd/features/asset_detail/core/domain/entities/asset_summary_entity.dart';

class AssetSummaryResponse extends AssetSummaryEntitiy {
  const AssetSummaryResponse({
    required super.assetName,
    required super.assetClassName,
    required super.custodian,
    required super.date,
    required super.dealNetWorth,
    required super.ytdPerformance,
    required super.itdPerformance,
    required super.dealContribution,
    required super.netChange,
    required super.unRealizedProfitLoss,
    required super.totalAssetsAmount,
    required super.isManuallyAdded,
    required super.totalQuantity,
  });

  factory AssetSummaryResponse.fromJson(Map<String, dynamic> json) =>
      AssetSummaryResponse(
        assetName: json["assetName"] ?? "",
        assetClassName: json["assetClassName"].toString(),
        custodian: json["custodian"] ?? "",
        date: DateTime.parse(json["date"]),
        dealNetWorth: json["dealNetWorth"],
        ytdPerformance: json["ytdPerformance"],
        itdPerformance: json["itdPerformance"],
        dealContribution: json["dealContribution"],
        netChange: json["netChange"],
        unRealizedProfitLoss: json["unrealizedGainLoss"] ?? 0,
        totalAssetsAmount: json["totalAssetsAmount"],
        isManuallyAdded: json["isManuallyAdded"],
        totalQuantity: json["totalQuantity"] ?? 0,
      );
}
