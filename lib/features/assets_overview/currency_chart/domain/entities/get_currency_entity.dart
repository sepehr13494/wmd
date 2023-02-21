import 'package:wmd/features/assets_overview/core/domain/entities/assets_overview_base_model.dart';

import '../../../core/domain/entities/assets_list_entity.dart';

class GetCurrencyEntity extends AssetsOverviewBaseModel{
    const GetCurrencyEntity({
        required this.currencyCode,
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

    final String currencyCode;


    Map<String, dynamic> toJson() => {
        "currencyCode": currencyCode,
        "totalAmount": totalAmount,
        "assetList": List<dynamic>.from(assetList.map((x) => x.toJson())),
        "yearToDate": yearToDate,
        "inceptionToDate": inceptionToDate,
    };

  @override
  List<Object?> get props => [
      currencyCode,
      totalAmount,
      assetList,
      yearToDate,
      inceptionToDate,
  ];
}

