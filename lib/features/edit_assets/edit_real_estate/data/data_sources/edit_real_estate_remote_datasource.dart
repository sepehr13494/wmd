import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/put_real_estate_params.dart';
import '../models/put_real_estate_response.dart';
import '../models/delete_real_estate_params.dart';
import '../models/delete_real_estate_response.dart';



abstract class EditRealEstateRemoteDataSource {
  Future<PutRealEstateResponse> putRealEstate(PutRealEstateParams params);
  Future<DeleteRealEstateResponse> deleteRealEstate(DeleteRealEstateParams params);

}

class EditRealEstateRemoteDataSourceImpl extends AppServerDataSource
    implements EditRealEstateRemoteDataSource {
  EditRealEstateRemoteDataSourceImpl(super.errorHandlerMiddleware);
  
    @override
  Future<PutRealEstateResponse> putRealEstate(PutRealEstateParams params) async {
    try{
      final appRequestOptions =
          AppRequestOptions(RequestTypes.put, AppUrls.putRealEstate, {
            ...params.addRealEstateParams.toJson(),
            "assetId":params.assetId,
          });
      final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = PutRealEstateResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format,data: e.toString(),stackTrace: e is TypeError ? e.stackTrace.toString() : null);
    }
  }
  
      @override
  Future<DeleteRealEstateResponse> deleteRealEstate(DeleteRealEstateParams params) async {
    try{
      final appRequestOptions =
          AppRequestOptions(RequestTypes.del, AppUrls.deleteRealEstate, params.toJson());
      final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = DeleteRealEstateResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format,data: e.toString(),stackTrace: e is TypeError ? e.stackTrace.toString() : null);
    }
  }
  
    
}
