import '../../domain/entities/get_all_valuation_entity.dart';

class GetAllValuationResponse extends GetAllValuationEntity {
  const GetAllValuationResponse({
    required super.amount,
    required super.id,
    // required super.currencyCode,
    required super.currencyToUsdFxRate,
    required super.amountInUsd,
    // required super.originCode,
    required super.valuatedAt,
    required super.isSystemGenerated,
    required super.isPm1Processed,
    // required super.assetId,
    // required super.liabilityId,
    // required super.createdAt,
    // required super.updatedAt,
    required super.note,
    required super.isLast,
  });

  factory GetAllValuationResponse.fromJson(Map<String, dynamic> json) =>
      GetAllValuationResponse(
        amount: double.tryParse(json["amount"].toString()) ?? 0,
        id: json["id"] ?? '',
        currencyToUsdFxRate:
            double.tryParse(json["conversionRate"].toString()) ?? 0,
        amountInUsd: double.tryParse(json["amountUSD"].toString()) ?? 0,
        isSystemGenerated: json["isSystemGenerated"] ?? false,
        isPm1Processed: json["isPm1Processed"] ?? false,
        // originCode: json["originCode"] ?? '',
        valuatedAt: DateTime.parse(json["transactionDate"]),
        // assetId: json["assetId"],
        // liabilityId: json["liabilityId"] ?? '',
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: json["updatedAt"] == null
        // ? null
        // : DateTime.parse(json["updatedAt"]),
        note: json["notes"] ?? '',
        isLast: json["isLast"] ?? false,
      );

  // static final tResponse = [GetAllValuationResponse()];
}
