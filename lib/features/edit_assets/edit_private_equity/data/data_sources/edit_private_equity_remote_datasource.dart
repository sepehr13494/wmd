import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/put_private_equity_params.dart';
import '../models/put_private_equity_response.dart';
import '../models/delete_private_equity_params.dart';
import '../models/delete_private_equity_response.dart';



abstract class EditPrivateEquityRemoteDataSource {
  Future<PutPrivateEquityResponse> putPrivateEquity(PutPrivateEquityParams params);
  Future<DeletePrivateEquityResponse> deletePrivateEquity(DeletePrivateEquityParams params);

}

class EditPrivateEquityRemoteDataSourceImpl extends AppServerDataSource
    implements EditPrivateEquityRemoteDataSource {
  EditPrivateEquityRemoteDataSourceImpl(super.errorHandlerMiddleware);
  
    @override
  Future<PutPrivateEquityResponse> putPrivateEquity(PutPrivateEquityParams params) async {
    try{
      final appRequestOptions =
          AppRequestOptions(RequestTypes.put, AppUrls.putPrivateEquity, {
            ...params.addPrivateEquityParams.toJson(),
            "assetId":params.assetId,
          });
      final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = PutPrivateEquityResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format,data: e.toString(),stackTrace: e is TypeError ? e.stackTrace.toString() : null);
    }
  }
  
      @override
  Future<DeletePrivateEquityResponse> deletePrivateEquity(DeletePrivateEquityParams params) async {
    try{
      final appRequestOptions =
          AppRequestOptions(RequestTypes.get, AppUrls.deletePrivateEquity, params.toJson());
      final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = DeletePrivateEquityResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format,data: e.toString(),stackTrace: e is TypeError ? e.stackTrace.toString() : null);
    }
  }
  
    
}
