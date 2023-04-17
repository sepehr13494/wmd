import 'package:equatable/equatable.dart';

import '../../../core/data/models/delete_asset_params.dart';

class DeleteOtherAssetsParams extends DeleteAssetParams{
  const DeleteOtherAssetsParams({required super.assetId});

  static const tParams = DeleteOtherAssetsParams(assetId: "1234");
}
    