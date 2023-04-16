import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/put_other_assets_params.dart';
import '../models/put_other_assets_response.dart';
import '../models/delete_other_assets_params.dart';
import '../models/delete_other_assets_response.dart';



abstract class EditOtherAssetsRemoteDataSource {
  Future<PutOtherAssetsResponse> putOtherAssets(PutOtherAssetsParams params);
  Future<DeleteOtherAssetsResponse> deleteOtherAssets(DeleteOtherAssetsParams params);

}

class EditOtherAssetsRemoteDataSourceImpl extends AppServerDataSource
    implements EditOtherAssetsRemoteDataSource {
  EditOtherAssetsRemoteDataSourceImpl(super.errorHandlerMiddleware);
  
    @override
  Future<PutOtherAssetsResponse> putOtherAssets(PutOtherAssetsParams params) async {
    try{
      final appRequestOptions =
          AppRequestOptions(RequestTypes.get, AppUrls.putOtherAssets, params.toJson());
      final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = PutOtherAssetsResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format,data: e.toString(),stackTrace: e is TypeError ? e.stackTrace.toString() : null);
    }
  }
  
      @override
  Future<DeleteOtherAssetsResponse> deleteOtherAssets(DeleteOtherAssetsParams params) async {
    try{
      final appRequestOptions =
          AppRequestOptions(RequestTypes.get, AppUrls.deleteOtherAssets, params.toJson());
      final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = DeleteOtherAssetsResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format,data: e.toString(),stackTrace: e is TypeError ? e.stackTrace.toString() : null);
    }
  }
  
    
}
