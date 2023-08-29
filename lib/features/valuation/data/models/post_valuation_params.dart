import 'package:equatable/equatable.dart';
import 'package:wmd/features/add_assets/core/data/models/currency.dart';

class PostValuationParams extends Equatable {
  final double? amount;
  final double? amountInUsd;
  final String? assetOrLiabilityId;
  final String? currencyCode;
  final double? currencyToUsdFxRate;
  final String? originCode;
  final String? wealthType;
  final DateTime? valuatedAt;
  final double? quantity;
  final double? pricePerUnit;
  final double? ownershipPercentage;
  final String? note;
  final String? type;

  const PostValuationParams({
    this.amount,
    this.amountInUsd,
    this.assetOrLiabilityId,
    this.currencyCode,
    this.currencyToUsdFxRate,
    this.originCode,
    this.wealthType,
    this.valuatedAt,
    this.quantity,
    this.pricePerUnit,
    this.ownershipPercentage,
    this.note,
    this.type,
  });

  factory PostValuationParams.fromJson(Map<String, dynamic> json) =>
      PostValuationParams(
          amount: json["amount"] != null
              ? double.tryParse(json["amount"].toString().replaceAll(',', ''))
              : json["amount"],
          amountInUsd: json["amountInUsd"] != null
              ? double.tryParse(json["amountInUsd"])
              : json["amountInUsd"],
          assetOrLiabilityId: json["assetOrLiabilityId"],
          currencyCode: (json["currencyCode"] as Currency).symbol,
          currencyToUsdFxRate: json["currencyToUsdFxRate"] != null
              ? double.tryParse(json["currencyToUsdFxRate"])
              : json["currencyToUsdFxRate"],
          originCode: json["originCode"],
          wealthType: json["wealthType"],
          valuatedAt: json["valuatedAt"] != null
              ? DateTime.parse(json["valuatedAt"].toString())
              : DateTime.now(),
          quantity: json["quantity"] != null
              ? double.tryParse(json["quantity"])
              : json["quantity"],
          pricePerUnit: json["pricePerUnit"] != null
              ? double.tryParse(
                  json["pricePerUnit"].toString().replaceAll(',', ''))
              : json["pricePerUnit"],
          ownershipPercentage: json["ownershipPercentage"] != null
              ? double.tryParse(json["ownershipPercentage"])
              : json["ownershipPercentage"],
          note: json["note"],
          type: json["type"]);

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "amountUSD": amountInUsd,
        "holdingId": assetOrLiabilityId,
        "currencyCode": currencyCode,
        "conversionRate": currencyToUsdFxRate,
        "originCode": originCode,
        "wealthType": wealthType,
        "transactionDate": valuatedAt?.toIso8601String(),
        "quantity": quantity ?? 0,
        "ownershipPercentage": ownershipPercentage ?? 100,
        "pricePerUnit": pricePerUnit,
        "notes": note,
        "type": type,
      };

  Map<String, dynamic> toValuationJson() => {
        "holdingId": assetOrLiabilityId,
        "currencyCode": currencyCode,
        "wealthType": wealthType,
        "valuatedAt": valuatedAt?.toIso8601String(),
        "amount": pricePerUnit,
        "notes": note,
        "type": type,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        amount,
        amountInUsd,
        assetOrLiabilityId,
        currencyCode,
        currencyToUsdFxRate,
        originCode,
        wealthType,
        valuatedAt,
        quantity,
        pricePerUnit,
        note,
        ownershipPercentage,
        type
      ];

  static final tParams = PostValuationParams(
    amount: 23232,
    amountInUsd: 2442,
    assetOrLiabilityId: "test",
    currencyCode: "test",
    currencyToUsdFxRate: 2424,
    originCode: "test",
    wealthType: "test",
    valuatedAt: DateTime.parse('2022-10-05T21:00:00.000Z'),
    quantity: 2332,
    pricePerUnit: 244,
    ownershipPercentage: 20,
    note: "test",
    type: "test",
  );
}
