import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/get_force_update_params.dart';
import '../models/get_force_update_response.dart';



abstract class ForceUpdateRemoteDataSource {
  Future<GetForceUpdateResponse> getForceUpdate(GetForceUpdateParams params);

}

class ForceUpdateRemoteDataSourceImpl extends AppServerDataSource
    implements ForceUpdateRemoteDataSource {
  ForceUpdateRemoteDataSourceImpl(super.errorHandlerMiddleware);
  
    @override
  Future<GetForceUpdateResponse> getForceUpdate(GetForceUpdateParams params) async {
    try{
      final appRequestOptions =
          AppRequestOptions(RequestTypes.get, AppUrls.getForceUpdate, params.toJson());
      final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = GetForceUpdateResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format,data: e.toString(),stackTrace: e is TypeError ? e.stackTrace.toString() : null);
    }
  }
  
    
}
