import 'package:wmd/features/asset_detail/core/data/models/get_detail_response.dart';
import 'package:wmd/features/asset_detail/private_debt/domain/entity/private_debt_entity.dart';

class PrivateDebtResponse extends PrivateDebtEntity
    implements GetDetailResponse {
  const PrivateDebtResponse({
    required super.investmentName,
    required super.investmentAmount,
    required super.investmentDate,
    required super.wealthManager,
    required super.marketValue,
    required super.valuationDate,
    required super.id,
    required super.type,
    required super.isActive,
    required super.country,
    required super.region,
    required super.currencyCode,
    required super.portfolioContribution,
    required super.holdings,
  });

  factory PrivateDebtResponse.fromJson(Map<String, dynamic> json) =>
      PrivateDebtResponse(
        investmentName: json["investmentName"] ?? '',
        investmentAmount:
            double.tryParse(json["investmentAmount"].toString()) ?? 0,
        investmentDate: DateTime.parse(json["investmentDate"] ??
            DateTime.fromMillisecondsSinceEpoch(0).toIso8601String()),
        wealthManager: json["wealthManager"] ?? '',
        marketValue: double.tryParse(json["marketValue"].toString()) ?? 0,
        holdings: double.tryParse(json["holdings"].toString()) ?? 0,
        valuationDate: DateTime.parse(json["valuationDate"] ??
            DateTime.fromMillisecondsSinceEpoch(0).toIso8601String()),
        id: json["id"] ?? '',
        type: json["type"] ?? '',
        isActive: json["isActive"] ?? '',
        country: json["country"] ?? '',
        region: json["region"] ?? '',
        currencyCode: json["currencyCode"] ?? '',
        portfolioContribution:
            double.tryParse(json["portfolioContribution"].toString()) ?? 0,
      );
}
