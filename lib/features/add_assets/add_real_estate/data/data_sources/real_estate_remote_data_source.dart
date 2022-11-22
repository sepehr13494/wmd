import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/add_assets/add_real_estate/domain/use_cases/add_real_estate_usecase.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';

abstract class RealEstateRemoteDataSource {
  Future<AddAssetModel> postRealEstate(AddRealEstateParams addRealEstateParams);
}

class RealEstateRemoteDataSourceImpl extends AppServerDataSource
    implements RealEstateRemoteDataSource {
  RealEstateRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<AddAssetModel> postRealEstate(
      AddRealEstateParams addRealEstateParams) async {
    final tPostPrivateDebtSaveRequestOptions = AppRequestOptions(
        RequestTypes.post,
        AppUrls.postRealEstate,
        addRealEstateParams.toJson());

    final response = await errorHandlerMiddleware
        .sendRequest(tPostPrivateDebtSaveRequestOptions);
    final result = AddAssetModel.fromJson(response);

    return result;
  }
}
