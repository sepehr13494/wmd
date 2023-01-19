import 'package:equatable/equatable.dart';

class GetChartEntity extends Equatable {
    const GetChartEntity({
        required this.date,
        required this.bankAccount,
        required this.realEstate,
        required this.privateEquity,
        required this.listedAssetEquity,
        required this.listedAssetFixedIncome,
        required this.listedAssetOther,
        required this.privateDebt,
        required this.others,
    });

    final String date;
    final double bankAccount;
    final double realEstate;
    final double privateEquity;
    final double listedAssetEquity;
    final double listedAssetFixedIncome;
    final double listedAssetOther;
    final double privateDebt;
    final double others;

    Map<String, dynamic> toJson() => {
        "date": date,
        "bankAccount": bankAccount,
        "realEstate": realEstate,
        "privateEquity": privateEquity,
        "listedAssetEquity": listedAssetEquity,
        "listedAssetFixedIncome": listedAssetFixedIncome,
        "listedAssetOther": listedAssetOther,
        "privateDebt": privateDebt,
        "others": others,
    };

    @override
    List<Object?> get props => [
        date,
        bankAccount,
        realEstate,
        privateEquity,
        listedAssetEquity,
        listedAssetFixedIncome,
        listedAssetOther,
        privateDebt,
        others,
    ];
}
    