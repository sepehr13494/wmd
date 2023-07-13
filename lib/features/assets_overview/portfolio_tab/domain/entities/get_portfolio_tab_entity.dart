import 'package:equatable/equatable.dart';

import '../../../core/domain/entities/assets_list_entity.dart';
import '../../../core/domain/entities/assets_overview_base_model.dart';

class GetPortfolioTabEntity extends AssetsOverviewBaseModel {
    const GetPortfolioTabEntity({
        required this.portfolioName,
        required this.custodianBank,
        required this.allocationPercentage,
        required double totalAmount,
        required List<AssetList> assetList,
        required double yearToDate,
        required double inceptionToDate,
    }) : super(
        totalAmount: totalAmount,
        assetList: assetList,
        yearToDate: yearToDate,
        inceptionToDate: inceptionToDate,
    );

    final String portfolioName;
    final String custodianBank;
    final double allocationPercentage;

    Map<String, dynamic> toJson() => {
        "portfolioName": portfolioName,
        "custodianBank": custodianBank,
        "allocationPercentage": allocationPercentage,
        "totalAmount": totalAmount,
        "assetList": List<dynamic>.from(assetList.map((x) => x.toJson())),
        "yearToDate": yearToDate,
        "inceptionToDate": inceptionToDate,
    };

    @override
    List<Object?> get props => [
        portfolioName,
        custodianBank,
        allocationPercentage,
        totalAmount,
        yearToDate,
        inceptionToDate,
    ];
}
    