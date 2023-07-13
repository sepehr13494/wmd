import '../../../core/data/models/delete_asset_params.dart';

class DeleteBankManualParams extends DeleteAssetParams{
    const DeleteBankManualParams({required super.assetId});

    static const tParams = DeleteBankManualParams(assetId: "1234");
}