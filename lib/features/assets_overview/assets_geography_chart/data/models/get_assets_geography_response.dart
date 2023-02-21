import '../../../core/data/models/assets_list_model.dart';
import '../../../core/domain/entities/assets_list_entity.dart';
import '../../domain/entities/get_assets_geography_entity.dart';

class GetAssetsGeographyResponse  extends GetAssetsGeographyEntity{
    const GetAssetsGeographyResponse({
      required String geography,
      required double totalAmount,
      required List<AssetList> assetList,
      required double yearToDate,
      required double inceptionToDate,
    }) : super(
        geography:geography,
        totalAmount:totalAmount,
        assetList:assetList,
        yearToDate:yearToDate,
        inceptionToDate:inceptionToDate,
    );

    factory GetAssetsGeographyResponse.fromJson(Map<String, dynamic> json) => GetAssetsGeographyResponse(
        geography: json["geography"],
        totalAmount: double.tryParse((json["totalAmount"]??0).toString()) ?? 0,
        assetList: List<AssetListResponse>.from(json["assetList"].map((x) => AssetListResponse.fromJson(x))),
        yearToDate: double.tryParse((json["yearToDate"]??0).toString()) ?? 0,
        inceptionToDate: double.tryParse((json["inceptionToDate"]??0).toString()) ?? 0,
    );
    
    static final tResponse = [GetAssetsGeographyResponse.fromJson({
        "geography": "Asia",
        "totalAmount": 122220,
        "assetList": [
            {
                "assetId": "8b3c15ac-c468-4b9f-a5b4-a2dc4966c91a",
                "assetName": "Test123",
                "currentValue": 1235555,
                "inceptionToDate": 10,
                "yearToDate": 10,
                "type": "BankAccount"
            }
        ],
        "yearToDate": 10,
        "inceptionToDate": 10
    })];
}