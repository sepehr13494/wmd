import '../../domain/entities/get_all_valuation_entity.dart';

class GetAllValuationResponse extends GetAllValuationEntity {
  const GetAllValuationResponse(
      {required super.amount,
      // required super.currencyCode,
      required super.currencyToUsdFxRate,
      required super.amountInUsd,
      // required super.originCode,
      required super.valuatedAt,
      // required super.assetId,
      // required super.liabilityId,
      // required super.createdAt,
      // required super.updatedAt,
      required super.note});

  factory GetAllValuationResponse.fromJson(Map<String, dynamic> json) =>
      GetAllValuationResponse(
        amount: double.tryParse(json["amount"].toString()) ?? 0,
        // currencyCode: json["currencyCode"] ?? '',
        currencyToUsdFxRate:
            double.tryParse(json["currencyToUsdFxRate"].toString()) ?? 0,
        amountInUsd: double.tryParse(json["amountInUsd"].toString()) ?? 0,
        // originCode: json["originCode"] ?? '',
        valuatedAt: DateTime.parse(json["valuatedAt"]),
        // assetId: json["assetId"],
        // liabilityId: json["liabilityId"] ?? '',
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: json["updatedAt"] == null
        // ? null
        // : DateTime.parse(json["updatedAt"]),
        note: json["note"] ?? '',
      );

  // static final tResponse = [GetAllValuationResponse()];
}
