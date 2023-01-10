import 'package:equatable/equatable.dart';

class ListedAssetEntity extends Equatable {
  const ListedAssetEntity({
    required this.securityName,
    required this.securityShortName,
    required this.tradedExchange,
    required this.brokerName,
    required this.isin,
    required this.category,
    required this.investmentDate,
    required this.asOfDate,
    required this.marketValue,
    required this.quantity,
    required this.totalCost,
    required this.couponRate,
    required this.maturityDate,
    required this.id,
    required this.type,
    required this.isActive,
    required this.country,
    required this.region,
    required this.currencyCode,
    required this.portfolioContribution,
    required this.holdings,
  });

  final String securityName;
  final String securityShortName;
  final String tradedExchange;
  final String brokerName;
  final String isin;
  final String category;
  final DateTime investmentDate;
  final DateTime? asOfDate;
  final double marketValue;
  final double quantity;
  final double totalCost;
  final double couponRate;
  final DateTime maturityDate;
  final String id;
  final double type;
  final bool isActive;
  final String country;
  final String region;
  final String currencyCode;
  final double portfolioContribution;
  final double holdings;

  Map<String, dynamic> toJson() => {
        "securityName": securityName,
        "securityShortName": securityShortName,
        "tradedExchange": tradedExchange,
        "brokerName": brokerName,
        "isin": isin,
        "category": category,
        "investmentDate": investmentDate.toIso8601String(),
        "marketValue": marketValue,
        "quantity": quantity,
        "totalCost": totalCost,
        "couponRate": couponRate,
        "maturityDate": maturityDate.toIso8601String(),
        "asOfDate": asOfDate?.toIso8601String(),
        "id": id,
        "type": type,
        "isActive": isActive,
        "country": country,
        "region": region,
        "currencyCode": currencyCode,
        "portfolioContribution": portfolioContribution,
        "holdings": holdings,
      };

  @override
  List<Object?> get props => [
        securityName,
        securityShortName,
        tradedExchange,
        brokerName,
        isin,
        category,
        investmentDate,
        marketValue,
        quantity,
        totalCost,
        asOfDate,
        couponRate,
        maturityDate,
        id,
        type,
        isActive,
        country,
        region,
        currencyCode,
        portfolioContribution,
        holdings,
      ];
}
