import 'package:equatable/equatable.dart';

class GetAllValuationEntity extends Equatable {
  const GetAllValuationEntity({
    required this.id,
    required this.amount,
    // required this.currencyCode,
    required this.currencyToUsdFxRate,
    required this.amountInUsd,
    // required this.originCode,
    required this.valuatedAt,
    required this.isSystemGenerated,
    required this.isPm1Processed,
    // required this.assetId,
    // required this.liabilityId,
    // required this.createdAt,
    // required this.updatedAt,
    required this.note,
  });

  final String id;
  final double amount;
  // final String? currencyCode;
  final double currencyToUsdFxRate;
  final double amountInUsd;
  // final String originCode;
  final DateTime valuatedAt;
  final bool isSystemGenerated;
  final bool isPm1Processed;
  // final String assetId;
  // final String? liabilityId;
  // final DateTime createdAt;
  // final DateTime? updatedAt;
  final String? note;

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        // "currencyCode": currencyCode,
        "currencyToUsdFxRate": currencyToUsdFxRate,
        "isSystemGenerated": isSystemGenerated,
        "isPm1Processed": isPm1Processed,
        "amountInUsd": amountInUsd,
        // "originCode": originCode,
        "valuatedAt": valuatedAt.toIso8601String(),
        // "assetId": assetId,
        // "liabilityId": liabilityId,
        // "createdAt": createdAt.toIso8601String(),
        // "updatedAt": updatedAt?.toIso8601String(),
        "note": note,
      };

  @override
  List<Object?> get props => [];
}
