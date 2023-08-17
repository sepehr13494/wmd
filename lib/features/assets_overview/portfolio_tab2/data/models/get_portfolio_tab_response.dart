import '../../../core/data/models/assets_list_model.dart';
import '../../../core/domain/entities/assets_list_entity.dart';
import '../../domain/entities/get_portfolio_tab_entity.dart';

class GetPortfolioTabResponse  extends GetPortfolioTabEntity{
    const GetPortfolioTabResponse({
        required String portfolioName,
        required String custodianBank,
        required double allocationPercentage,
        required double totalAmount,
        required List<AssetList> assetList,
        required double yearToDate,
        required double inceptionToDate,
    }) : super(
        portfolioName:portfolioName,
        custodianBank:custodianBank,
        allocationPercentage:allocationPercentage,
        totalAmount:totalAmount,
        assetList:assetList,
        yearToDate:yearToDate,
        inceptionToDate:inceptionToDate,
    );

    factory GetPortfolioTabResponse.fromJson(Map<String, dynamic> json) => GetPortfolioTabResponse(
        portfolioName: json["portfolioName"]??"",
        custodianBank: json["custodianBank"]??"",
        allocationPercentage: double.tryParse((json["allocationPercentage"]??0).toString()) ?? 0,
        totalAmount: double.tryParse((json["totalAmount"]??0).toString()) ?? 0,
        assetList: List<AssetListResponse>.from(json["assetList"].map((x) => AssetListResponse.fromJson(x))),
        yearToDate: double.tryParse((json["yearToDate"]??0).toString()) ?? 0,
        inceptionToDate: double.tryParse((json["inceptionToDate"]??0).toString()) ?? 0,
    );

    static final tResponse = [GetPortfolioTabResponse.fromJson({
        "portfolioName": "Portfolio 3",
        "custodianBank": "Custodian Bank 3",
        "totalAmount": 457740.620016732,
        "assetList": [
            {
                "assetId": "17648",
                "currency": "JPY",
                "assetName": "GLG Japan CoreAlpha Equity I",
                "subType": null,
                "currentValue": 257740.620016732,
                "inceptionToDate": 0,
                "yearToDate": 0,
                "geography": "Asia",
                "type": "ListedAssetEquity"
            },
            {
                "assetId": "17648",
                "currency": "JPY",
                "assetName": "GLG Japan CoreAlpha Equity I",
                "subType": null,
                "currentValue": 357740.620016732,
                "inceptionToDate": 0,
                "yearToDate": 0,
                "geography": "Asia",
                "type": "ListedAssetEquity"
            }
        ],
        "yearToDate": 0,
        "inceptionToDate": 0,
        "allocationPercentage": 6.9941907451691865
    })];
}
    