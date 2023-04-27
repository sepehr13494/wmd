import 'package:wmd/features/valuation/domain/entities/get_valuation_entity.dart';

class GetValuationResponse extends GetValuationEntity {
  const GetValuationResponse(
      {required super.amount,
      required super.id,
      required super.currencyCode,
      required super.currencyToUsdFxRate,
      required super.amountInUsd,
      // required super.originCode,
      required super.valuatedAt,
      required super.isSystemGenerated,
      required super.isPm1Processed,
      required super.assetId,
      required super.type,
      // required super.liabilityId,
      required super.createdAt,
      required super.updatedAt,
      required super.note});

  factory GetValuationResponse.fromJson(Map<String, dynamic> json) =>
      GetValuationResponse(
        amount: double.tryParse(json["amount"].toString()) ?? 0,
        id: json["id"] ?? '',
        currencyCode: json["currencyCode"],
        currencyToUsdFxRate:
            double.tryParse(json["currencyToUsdFxRate"].toString()) ?? 0,
        amountInUsd: double.tryParse(json["amountInUsd"].toString()) ?? 0,
        isSystemGenerated: json["isSystemGenerated"] ?? false,
        isPm1Processed: json["isPm1Processed"] ?? false,
        // originCode: json["originCode"] ?? '',
        valuatedAt: DateTime.parse(json["valuatedAt"]),
        assetId: json["assetId"],
        type: json["type"],
        // liabilityId: json["liabilityId"] ?? '',
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        note: json["note"] ?? '',
      );

  // static final tResponse = [GetAllValuationResponse()];
}