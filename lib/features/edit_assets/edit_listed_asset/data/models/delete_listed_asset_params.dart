import 'package:equatable/equatable.dart';

import '../../../core/data/models/delete_asset_params.dart';

class DeleteListedAssetParams extends DeleteAssetParams{
    const DeleteListedAssetParams({required super.assetId});

    static const tParams = DeleteListedAssetParams(assetId: "1234");
}
