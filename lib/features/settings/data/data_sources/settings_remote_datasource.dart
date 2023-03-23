import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/get_settings_params.dart';
import '../models/get_settings_response.dart';
import '../models/put_settings_params.dart';
import '../models/put_settings_response.dart';

abstract class SettingsRemoteDataSource {
  Future<GetSettingsResponse> getSettings(GetSettingsParams params);
  Future<PutSettingsResponse> putSettings(PutSettingsParams params);
}

class SettingsRemoteDataSourceImpl extends AppServerDataSource
    implements SettingsRemoteDataSource {
  SettingsRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<GetSettingsResponse> getSettings(GetSettingsParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.get, AppUrls.settings, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = GetSettingsResponse.fromJson(response);
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
  Future<PutSettingsResponse> putSettings(PutSettingsParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.put, AppUrls.settings, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = PutSettingsResponse.fromJson(response);
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
