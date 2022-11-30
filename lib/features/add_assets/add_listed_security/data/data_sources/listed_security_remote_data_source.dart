import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/add_assets/add_listed_security/domain/use_cases/add_listed_security_usecase.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';

abstract class ListedSecurityRemoteDataSource {
  Future<AddAssetModel> postListedSecurity(
      AddListedSecurityParams addListedSecurityParams);
}

class ListedSecurityRemoteDataSourceImpl extends AppServerDataSource
    implements ListedSecurityRemoteDataSource {
  ListedSecurityRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<AddAssetModel> postListedSecurity(
      AddListedSecurityParams addListedSecurityParams) async {
    final tPostSaveRequestOptions = AppRequestOptions(RequestTypes.post,
        AppUrls.postListedAsset, addListedSecurityParams.toJson());

    final response =
        await errorHandlerMiddleware.sendRequest(tPostSaveRequestOptions);
    final result = AddAssetModel.fromJson(response);

    return result;
  }
}
