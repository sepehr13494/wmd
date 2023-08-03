import '../../domain/entities/get_manual_list_entity.dart';

class GetManualListResponse extends GetManualListEntity {
    const GetManualListResponse({
        required String id,
        required String bankName,
        required String country,
        required String countryIso2,
    }) : super(
        id: id,
        bankName: bankName,
        country: country,
        countryIso2: countryIso2,
    );

    factory GetManualListResponse.fromJson(Map<String, dynamic> json) => GetManualListResponse(
        id: json["id"]??"",
        bankName: json["bankName"]??"",
        country: json["country"]??"",
        countryIso2: json["countryIso2"]??"",
    );

    static final tResponse = [
    GetManualListResponse.fromJson(const {
        "id": "7d108f64-34b6-41a9-aa6a-1a272b1ff98e",
        "bankName": "Banka Creditas (cs)",
        "country": "Czechia",
        "countryIso2": "CZ"
    })
  ];
}
