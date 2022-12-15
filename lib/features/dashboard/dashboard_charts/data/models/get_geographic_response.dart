import '../../domain/entities/get_geographic_entity.dart';

class GetGeographicResponse  extends GetGeographicEntity{
    const GetGeographicResponse({
        required String continent,
        required double amount,
        required double percentage,
    }) : super(
        continent: continent,
        amount: amount,
        percentage: percentage,
    );

    factory GetGeographicResponse.fromJson(Map<String, dynamic> json) => GetGeographicResponse(
        continent: json["continent"]??"",
        amount: double.tryParse(json["amount"].toString())??0,
        percentage: double.tryParse(json["percentage"].toString())??0,
    );

    static final tResponse = [
        GetGeographicResponse(continent: "testName", percentage: 60, amount: 6000),
        GetGeographicResponse(continent: "testName2", percentage: 40, amount: 4000),
    ];
}
    