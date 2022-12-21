import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/reset_params.dart';
import '../models/reset_response.dart';



abstract class ProfileResetPasswordRemoteDataSource {
  Future<ResetResponse> reset(ResetParams params);

}

class ProfileResetPasswordRemoteDataSourceImpl extends AppServerDataSource
    implements ProfileResetPasswordRemoteDataSource {
  ProfileResetPasswordRemoteDataSourceImpl(super.errorHandlerMiddleware);
  
    @override
  Future<ResetResponse> reset(ResetParams params) async {
    try{
      final appRequestOptions =
          AppRequestOptions(RequestTypes.post, AppUrls.reset, params.toJson());
      final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = ResetResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }
  
    
}
