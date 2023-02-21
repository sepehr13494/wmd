import '../../domain/entities/get_currency_entity.dart';

class GetCurrencyResponse extends GetCurrencyEntity{
    const GetCurrencyResponse({
       required String currencyCode,
       required double totalAmount,
       required List<AssetListResponse> assetList,
       required double yearToDate,
       required double inceptionToDate,
    }) : super(
        currencyCode:currencyCode,
        totalAmount:totalAmount,
        assetList:assetList,
        yearToDate:yearToDate,
        inceptionToDate:inceptionToDate,
    );

    factory GetCurrencyResponse.fromJson(Map<String, dynamic> json) => GetCurrencyResponse(
        currencyCode: json["currencyCode"],
        totalAmount: double.tryParse(json["totalAmount"].toString()) ?? 0,
        assetList: List<AssetListResponse>.from(json["assetList"].map((x) => AssetListResponse.fromJson(x))),
        yearToDate: double.tryParse(json["yearToDate"].toString()) ?? 0,
        inceptionToDate: double.tryParse(json["inceptionToDate"].toString()) ?? 0,
    );

    static final tResponse = [GetCurrencyResponse.fromJson(const {
        "currencyCode": "USD",
        "totalAmount": 5626422.86641549,
        "assetList": [
            {
                "assetId": "24601",
                "currency": "USD",
                "assetName": "Multi Manager EmMa Debt BI",
                "subType": null,
                "currentValue": 0.0,
                "inceptionToDate": 0.0,
                "yearToDate": 0.0,
                "geography": "Europe",
                "type": "ListedAssetFixedIncome"
            }
        ],
        "yearToDate": 0.0,
        "inceptionToDate": 0.0
    })];

}

class AssetListResponse extends AssetList {
    const AssetListResponse({
       required String assetId,
       required String currency,
       required String assetName,
       dynamic subType,
       required double currentValue,
       required double inceptionToDate,
       required double yearToDate,
       required String geography,
       required String type,
    }) : super(
        assetId : assetId,
        currency : currency,
        assetName : assetName,
        subType : subType,
        currentValue : currentValue,
        inceptionToDate : inceptionToDate,
        yearToDate : yearToDate,
        geography : geography,
        type : type,
    );

    factory AssetListResponse.fromJson(Map<String, dynamic> json) => AssetListResponse(
        assetId: json["assetId"] ?? "",
        currency: json["currency"] ?? "",
        assetName: json["assetName"] ?? "",
        subType: json["subType"],
        currentValue: double.tryParse(json["currentValue"].toString()) ?? 0,
        inceptionToDate: double.tryParse(json["inceptionToDate"].toString()) ?? 0,
        yearToDate: double.tryParse(json["yearToDate"].toString()) ?? 0,
        geography: json["geography"] ?? "",
        type: json["type"] ?? "",
    );
}