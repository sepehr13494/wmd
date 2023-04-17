import 'package:equatable/equatable.dart';

class GetAssetClassEntity extends Equatable {

    const GetAssetClassEntity({
        required this.assetName,
        required this.marketValue,
        required this.forexValue,
        required this.income,
        required this.commission,
        required this.total,
        required this.changePercentage,
    });

    final String assetName;
    final double marketValue;
    final double forexValue;
    final double income;
    final double commission;
    final double total;
    final double changePercentage;

    Map<String, dynamic> toJson() => {
        "assetName": assetName,
        "marketValue": marketValue,
        "forexValue": forexValue,
        "income": income,
        "commission": commission,
        "total": total,
        "changePercentage": changePercentage,
    };

    @override
    List<Object?> get props => [
        assetName,
        marketValue,
        forexValue,
        income,
        commission,
        total,
        changePercentage,
    ];
}
    