import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/post_verify_phone_params.dart';
import '../models/post_verify_phone_response.dart';
import '../models/post_resend_verify_phone_params.dart';
import '../models/post_resend_verify_phone_response.dart';

abstract class VerifyPhoneRemoteDataSource {
  Future<PostVerifyPhoneResponse> postVerifyPhone(PostVerifyPhoneParams params);
  Future<PostResendVerifyPhoneResponse> postResendVerifyPhone(
      PostResendVerifyPhoneParams params);
}

class VerifyPhoneRemoteDataSourceImpl extends AppServerDataSource
    implements VerifyPhoneRemoteDataSource {
  VerifyPhoneRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<PostVerifyPhoneResponse> postVerifyPhone(
      PostVerifyPhoneParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.post, AppUrls.postVerifyPhone, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = PostVerifyPhoneResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }

  @override
  Future<PostResendVerifyPhoneResponse> postResendVerifyPhone(
      PostResendVerifyPhoneParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.post, AppUrls.postResendVerifyPhone, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = PostResendVerifyPhoneResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }
}
