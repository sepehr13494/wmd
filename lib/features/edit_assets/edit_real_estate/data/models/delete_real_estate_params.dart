import 'package:wmd/features/edit_assets/core/data/models/delete_asset_params.dart';

class DeleteRealEstateParams extends DeleteAssetParams{
  const DeleteRealEstateParams({required super.assetId});

  static const tParams = DeleteRealEstateParams(assetId: "1234");
}
