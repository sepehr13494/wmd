import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/put_listed_asset_params.dart';
import '../models/put_listed_asset_response.dart';
import '../models/delete_listed_asset_params.dart';
import '../models/delete_listed_asset_response.dart';



abstract class EditListedAssetRemoteDataSource {
  Future<PutListedAssetResponse> putListedAsset(PutListedAssetParams params);
  Future<DeleteListedAssetResponse> deleteListedAsset(DeleteListedAssetParams params);

}

class EditListedAssetRemoteDataSourceImpl extends AppServerDataSource
    implements EditListedAssetRemoteDataSource {
  EditListedAssetRemoteDataSourceImpl(super.errorHandlerMiddleware);
  
    @override
  Future<PutListedAssetResponse> putListedAsset(PutListedAssetParams params) async {
    try{
      final appRequestOptions =
          AppRequestOptions(RequestTypes.put, AppUrls.putListedAsset, params.toServerJson());
      final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = PutListedAssetResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format,data: e.toString(),stackTrace: e is TypeError ? e.stackTrace.toString() : null);
    }
  }
  
      @override
  Future<DeleteListedAssetResponse> deleteListedAsset(DeleteListedAssetParams params) async {
    try{
      final appRequestOptions =
          AppRequestOptions(RequestTypes.del, AppUrls.deleteListedAsset, params.toJson());
      final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = DeleteListedAssetResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format,data: e.toString(),stackTrace: e is TypeError ? e.stackTrace.toString() : null);
    }
  }
  
    
}
