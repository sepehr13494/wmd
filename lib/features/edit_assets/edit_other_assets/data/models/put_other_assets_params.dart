import 'package:equatable/equatable.dart';
import 'package:wmd/features/add_assets/add_other_asset/domain/use_cases/add_other_asset_usecase.dart';

class PutOtherAssetsParams extends Equatable{
    final String assetId;
    final AddOtherAssetParams addOtherAssetParams;
    const PutOtherAssetsParams({required this.assetId, required this.addOtherAssetParams});

    factory PutOtherAssetsParams.fromJson(Map<String, dynamic> json) => PutOtherAssetsParams(
        assetId: json["assetId"],
        addOtherAssetParams: AddOtherAssetParams.fromJson(json["addOtherAssetParams"])
    );

    Map<String, dynamic> toJson() => {
        "assetId":assetId,
        "bankSaveParams":addOtherAssetParams.toJson()
    };

    @override
    List<Object?> get props => [
        assetId,
        addOtherAssetParams,
    ];
    
    static final tParams = PutOtherAssetsParams(assetId: "1234",addOtherAssetParams: AddOtherAssetParams.tAddOtherAssetParams);
}
    