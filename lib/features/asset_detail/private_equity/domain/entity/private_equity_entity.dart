import 'package:equatable/equatable.dart';

class PrivateEquityEntity extends Equatable {
  const PrivateEquityEntity({
    required this.investmentName,
    required this.investmentAmount,
    required this.investmentDate,
    required this.wealthManager,
    required this.marketValue,
    required this.valuationDate,
    required this.id,
    required this.type,
    required this.isActive,
    required this.asOfDate,
    required this.country,
    required this.region,
    required this.currencyCode,
    required this.portfolioContribution,
    required this.holdings,
  });

  final String investmentName;
  final double investmentAmount;
  final DateTime investmentDate;
  final String wealthManager;
  final double marketValue;
  final DateTime valuationDate;
  final DateTime? asOfDate;
  final String id;
  final String type;
  final bool isActive;
  final String country;
  final String region;
  final String currencyCode;
  final double portfolioContribution;
  final double holdings;

  Map<String, dynamic> toJson() => {
        "investmentName": investmentName,
        "investmentAmount": investmentAmount,
        "investmentDate": investmentDate.toIso8601String(),
        "wealthManager": wealthManager,
        "marketValue": marketValue,
        "valuationDate": valuationDate.toIso8601String(),
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
        investmentName,
        investmentAmount,
        investmentDate,
        wealthManager,
        marketValue,
        valuationDate,
        id,
        type,
        asOfDate,
        isActive,
        country,
        region,
        currencyCode,
        portfolioContribution,
        holdings,
      ];
}
