import 'package:equatable/equatable.dart';

import '../../../core/domain/entities/assets_list_entity.dart';
import '../../../core/domain/entities/assets_overview_base_model.dart';

class GetAssetsGeographyEntity  extends AssetsOverviewBaseModel{
    const GetAssetsGeographyEntity({
        required this.geography,
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

    final String geography;

    Map<String, dynamic> toJson() => {
        "geography": geography,
        "totalAmount": totalAmount,
        "assetList": List<dynamic>.from(assetList.map((x) => x.toJson())),
        "yearToDate": yearToDate,
        "inceptionToDate": inceptionToDate,
    };

    @override
    List<Object?> get props => [
        geography,
        totalAmount,
        yearToDate,
        inceptionToDate,
    ];
}