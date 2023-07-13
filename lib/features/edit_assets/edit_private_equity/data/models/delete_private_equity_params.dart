import '../../../core/data/models/delete_asset_params.dart';

class DeletePrivateEquityParams extends DeleteAssetParams{
    const DeletePrivateEquityParams({required super.assetId});

    static const tParams = DeletePrivateEquityParams(assetId: "1234");
}