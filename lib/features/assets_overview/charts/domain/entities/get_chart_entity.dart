import 'package:equatable/equatable.dart';

class GetChartEntity extends Equatable {
    const GetChartEntity({
        required this.date,
        required this.bankAccount,
        required this.realEstate,
        required this.privateEquity,
        required this.listedAsset,
        required this.privateDebt,
        required this.others,
    });

    final String date;
    final double bankAccount;
    final double realEstate;
    final double privateEquity;
    final double listedAsset;
    final double privateDebt;
    final double others;

    Map<String, dynamic> toJson() => {
        "date": date,
        "bankAccount": bankAccount,
        "realEstate": realEstate,
        "privateEquity": privateEquity,
        "listedAsset": listedAsset,
        "privateDebt": privateDebt,
        "others": others,
    };

    @override
    List<Object?> get props => [
        date,
        bankAccount,
        realEstate,
        privateEquity,
        listedAsset,
        privateDebt,
        others,
    ];
}
    