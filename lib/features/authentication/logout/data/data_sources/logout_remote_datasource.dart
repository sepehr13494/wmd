import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/perform_logout_params.dart';
import '../models/perform_logout_response.dart';



abstract class LogoutRemoteDataSource {
  Future<PerformLogoutResponse> performLogout(PerformLogoutParams params);

}

class LogoutRemoteDataSourceImpl extends AppServerDataSource
    implements LogoutRemoteDataSource {
  LogoutRemoteDataSourceImpl(super.errorHandlerMiddleware);
  
    @override
  Future<PerformLogoutResponse> performLogout(PerformLogoutParams params) async {
    try{
      final appRequestOptions =
          AppRequestOptions(RequestTypes.post, AppUrls.performLogout, params.toJson());
      final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = PerformLogoutResponse();
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format,data: e.toString(),stackTrace: e is TypeError ? e.stackTrace.toString() : null);
    }
  }
  
    
}
