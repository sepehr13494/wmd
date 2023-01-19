import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/get_asset_see_more_params.dart';
import '../models/get_asset_see_more_response.dart';

abstract class AssetSeeMoreRemoteDataSource {
  Future<GetSeeMoreResponse> getAssetSeeMore(GetSeeMoreParams params);
}

class AssetSeeMoreRemoteDataSourceImpl extends AppServerDataSource
    implements AssetSeeMoreRemoteDataSource {
  AssetSeeMoreRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<GetSeeMoreResponse> getAssetSeeMore(GetSeeMoreParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.get, AppUrls.getSeeMore(params.type), params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = GetSeeMoreResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }
}
