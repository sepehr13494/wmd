import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/patch_preference_mobile_banner_params.dart';
import '../models/patch_preference_mobile_banner_response.dart';
import '../models/patch_preference_language_params.dart';
import '../models/patch_preference_language_response.dart';
import '../models/get_preference_params.dart';
import '../models/get_preference_response.dart';

abstract class PreferenceRemoteDataSource {
  Future<PatchPreferenceMobileBannerResponse> patchPreferenceMobileBanner(
      PatchPreferenceMobileBannerParams params);
  Future<PatchPreferenceLanguageResponse> patchPreferenceLanguage(
      PatchPreferenceLanguageParams params);
  Future<GetPreferenceResponse> getPreference(GetPreferenceParams params);
}

class PreferenceRemoteDataSourceImpl extends AppServerDataSource
    implements PreferenceRemoteDataSource {
  PreferenceRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<PatchPreferenceMobileBannerResponse> patchPreferenceMobileBanner(
      PatchPreferenceMobileBannerParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(RequestTypes.patch,
          AppUrls.patchPreferenceMobileBanner, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = PatchPreferenceMobileBannerResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }

  @override
  Future<PatchPreferenceLanguageResponse> patchPreferenceLanguage(
      PatchPreferenceLanguageParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.patch, AppUrls.patchPreferenceLanguage, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = PatchPreferenceLanguageResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }

  @override
  Future<GetPreferenceResponse> getPreference(
      GetPreferenceParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.get, AppUrls.getPreference, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = GetPreferenceResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }
}
