import 'package:equatable/equatable.dart';

class GetAssetClassEntity extends Equatable {

    const GetAssetClassEntity({
        required this.assetName,
        required this.marketValue,
        required this.forexValue,
        required this.income,
        required this.commision,
        required this.total,
        required this.changePercentage,
    });

    final String assetName;
    final int marketValue;
    final int forexValue;
    final int income;
    final int commision;
    final int total;
    final double changePercentage;

    Map<String, dynamic> toJson() => {
        "assetName": assetName,
        "marketValue": marketValue,
        "forexValue": forexValue,
        "income": income,
        "commision": commision,
        "total": total,
        "changePercentage": changePercentage,
    };

    @override
    List<Object?> get props => [
        assetName,
        marketValue,
        forexValue,
        income,
        commision,
        total,
        changePercentage,
    ];
}
    