import 'package:equatable/equatable.dart';

class AssetSummaryEntitiy extends Equatable {
  const AssetSummaryEntitiy({
    required this.assetName,
    required this.assetClassName,
    required this.custodian,
    required this.date,
    required this.dealNetWorth,
    required this.ytdPerformance,
    required this.itdPerformance,
    required this.dealContribution,
    required this.netChange,
    required this.unRealizedProfitLoss,
    required this.totalAssetsAmount,
    required this.isManuallyAdded,
    required this.totalQuantity,
  });

  final String assetName;
  final String assetClassName;
  final String custodian;
  final DateTime date;
  final double dealNetWorth;
  final double ytdPerformance;
  final double itdPerformance;
  final double dealContribution;
  final double netChange;
  final double unRealizedProfitLoss;
  final double totalAssetsAmount;
  final bool isManuallyAdded;
  final double totalQuantity;

  Map<String, dynamic> toJson() => {
        "assetName": assetName,
        "assetClassName": assetClassName,
        "custodian": custodian,
        "date": date.toIso8601String(),
        "dealNetWorth": dealNetWorth,
        "ytdPerformance": ytdPerformance,
        "itdPerformance": itdPerformance,
        "dealContribution": dealContribution,
        "netChange": netChange,
        "unRealizedProfitLoss": unRealizedProfitLoss,
        "totalAssetsAmount": totalAssetsAmount,
        "isManuallyAdded": isManuallyAdded,
        "totalQuantity": totalQuantity,
      };

  @override
  List<Object?> get props => [
        assetName,
        assetClassName,
        custodian,
        date,
        dealNetWorth,
        ytdPerformance,
        itdPerformance,
        dealContribution,
        netChange,
        totalAssetsAmount,
        isManuallyAdded,
        totalQuantity
      ];

  String get assetNameFixed => assetName.replaceAll(RegExp(r"\s+"), " ");
}
