import '../../../core/data/models/delete_asset_params.dart';

class DeletePrivateDebtParams extends DeleteAssetParams{
    const DeletePrivateDebtParams({required super.assetId});

    static const tParams = DeletePrivateDebtParams(assetId: "1234");
}
    