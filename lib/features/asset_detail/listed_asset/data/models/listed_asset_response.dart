import 'package:wmd/features/asset_detail/core/data/models/get_detail_response.dart';
import 'package:wmd/features/asset_detail/listed_asset/domain/entity/listed_asset_entity.dart';

class ListedAssetResponse extends ListedAssetEntity
    implements GetDetailResponse {
  const ListedAssetResponse({
    required super.securityName,
    required super.securityShortName,
    required super.tradedExchange,
    required super.brokerName,
    required super.isin,
    required super.category,
    required super.investmentDate,
    required super.marketValue,
    required super.quantity,
    required super.totalCost,
    required super.couponRate,
    required super.maturityDate,
    required super.id,
    required super.type,
    required super.isActive,
    required super.country,
    required super.region,
    required super.currencyCode,
    required super.portfolioContribution,
    required super.holdings,
  });

  factory ListedAssetResponse.fromJson(Map<String, dynamic> json) =>
      ListedAssetResponse(
        securityName: json["securityName"],
        securityShortName: json["securityShortName"],
        tradedExchange: json["tradedExchange"],
        brokerName: json["brokerName"],
        isin: json["isin"],
        category: json["category"],
        investmentDate: DateTime.parse(json["investmentDate"] ??
            DateTime.fromMillisecondsSinceEpoch(0).toIso8601String()),
        marketValue: double.tryParse(json['marketValue'].toString()) ?? 0,
        quantity: double.tryParse(json['quantity'].toString()) ?? 0,
        totalCost: double.tryParse(json['totalCost'].toString()) ?? 0,
        couponRate: double.tryParse(json['couponRate'].toString()) ?? 0,
        maturityDate: DateTime.parse(json["maturityDate"] ??
            DateTime.fromMillisecondsSinceEpoch(0).toIso8601String()),
        id: json["id"],
        type: json["type"],
        isActive: json["isActive"],
        country: json["country"],
        region: json["region"],
        currencyCode: json["currencyCode"],
        portfolioContribution: json["portfolioContribution"].toDouble(),
        holdings: double.tryParse(json['holdings'].toString()) ?? 0,
      );
}
