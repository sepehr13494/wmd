import '../../domain/entities/get_chart_entity.dart';

class GetChartResponse extends GetChartEntity{
    const GetChartResponse({
       required String date,
       required double bankAccount,
       required double realEstate,
       required double privateEquity,
       required double listedAsset,
       required double privateDebt,
       required double others,
    }) : super(
        date : date,
        bankAccount : bankAccount,
        realEstate : realEstate,
        privateEquity : privateEquity,
        listedAsset : listedAsset,
        privateDebt : privateDebt,
        others : others,
    );

    factory GetChartResponse.fromJson(Map<String, dynamic> json) => GetChartResponse(
        date: json["date"],
        bankAccount: json["bankAccount"],
        realEstate: json["realEstate"],
        privateEquity: json["privateEquity"],
        listedAsset: json["listedAsset"],
        privateDebt: json["privateDebt"],
        others: json["others"],
    );

    static final tResponse = GetChartResponse.fromJson(const {"date": "12/18/2022", "bankAccount": 1050000.0, "realEstate": 3000000.0, "privateEquity": 0.0, "listedAsset": 0.0, "privateDebt": 0.0, "others": 0.0});
}
    