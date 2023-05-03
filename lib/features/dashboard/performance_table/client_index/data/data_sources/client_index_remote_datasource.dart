import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/get_client_index_params.dart';
import '../models/get_client_index_response.dart';



abstract class ClientIndexRemoteDataSource {
  Future<GetClientIndexResponse> getClientIndex(GetClientIndexParams params);

}

class ClientIndexRemoteDataSourceImpl extends AppServerDataSource
    implements ClientIndexRemoteDataSource {
  ClientIndexRemoteDataSourceImpl(super.errorHandlerMiddleware);
  
    @override
  Future<GetClientIndexResponse> getClientIndex(GetClientIndexParams params) async {
    try{
      final appRequestOptions =
          AppRequestOptions(RequestTypes.get, AppUrls.getClientIndex, params.toJson());
      final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = GetClientIndexResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format,data: e.toString(),stackTrace: e is TypeError ? e.stackTrace.toString() : null);
    }
  }
  
    
}
