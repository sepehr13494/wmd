import 'package:equatable/equatable.dart';
import 'package:wmd/core/extentions/num_ext.dart';
import 'package:wmd/features/add_assets/core/data/models/currency.dart';

class GetValuationEntity extends Equatable {
  const GetValuationEntity({
    required this.id,
    required this.amount,
    this.pricePerUnit,
    required this.currencyCode,
    required this.currencyToUsdFxRate,
    required this.amountInUsd,
    // required this.originCode,
    required this.valuatedAt,
    required this.isSystemGenerated,
    required this.isPm1Processed,
    required this.assetId,
    required this.type,
    // required this.liabilityId,
    required this.createdAt,
    required this.updatedAt,
    required this.note,
  });

  final String id;
  final double amount;
  final double? pricePerUnit;
  final String currencyCode;
  final double currencyToUsdFxRate;
  final double amountInUsd;
  // final String originCode;
  final DateTime valuatedAt;
  final bool isSystemGenerated;
  final bool isPm1Processed;
  final String assetId;
  final String type;
  // final String? liabilityId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? note;

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "pricePerUnit": pricePerUnit,
        "currencyCode": currencyCode,
        "currencyToUsdFxRate": currencyToUsdFxRate,
        "isSystemGenerated": isSystemGenerated,
        "isPm1Processed": isPm1Processed,
        "amountInUsd": amountInUsd,
        // "originCode": originCode,
        "valuatedAt": valuatedAt.toIso8601String(),
        "assetId": assetId,
        "type": type,
        // "liabilityId": liabilityId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "note": note,
      };

  Map<String, dynamic> toFormJson() => {
        "id": id,
        "amount": amount.convertMoney(),
        "pricePerUnit":
            pricePerUnit != null ? pricePerUnit?.convertMoney() : pricePerUnit,
        "currencyCode": Currency.getCurrencyFromString(currencyCode),
        "currencyToUsdFxRate": currencyToUsdFxRate,
        "isSystemGenerated": isSystemGenerated,
        "isPm1Processed": isPm1Processed,
        "amountInUsd": amountInUsd,
        // "originCode": originCode,
        "valuatedAt": valuatedAt,
        "assetId": assetId,
        "type": type,
        // "liabilityId": liabilityId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "note": note,
      };

  @override
  List<Object?> get props => [];
}
