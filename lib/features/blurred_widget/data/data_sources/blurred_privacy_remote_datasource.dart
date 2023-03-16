import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/get_is_blurred_params.dart';
import '../models/get_is_blurred_response.dart';
import '../models/set_blurred_params.dart';
import '../models/set_blurred_response.dart';

abstract class BlurredPrivacyRemoteDataSource {
  Future<GetIsBlurredResponse> getIsBlurred(GetIsBlurredParams params);
  Future<SetBlurredResponse> setBlurred(SetBlurredParams params);
}

class BlurredPrivacyRemoteDataSourceImpl extends AppServerDataSource
    implements BlurredPrivacyRemoteDataSource {
  BlurredPrivacyRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<GetIsBlurredResponse> getIsBlurred(GetIsBlurredParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.get, AppUrls.isBlurred, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = GetIsBlurredResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception",
          type: ExceptionType.format,
          data: e.toString(),
          stackTrace: e is TypeError ? e.stackTrace.toString() : null);
    }
  }

  @override
  Future<SetBlurredResponse> setBlurred(SetBlurredParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.get, AppUrls.isBlurred, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = SetBlurredResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception",
          type: ExceptionType.format,
          data: e.toString(),
          stackTrace: e is TypeError ? e.stackTrace.toString() : null);
    }
  }
}
