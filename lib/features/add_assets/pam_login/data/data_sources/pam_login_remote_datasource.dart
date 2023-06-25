import 'dart:convert';
import 'dart:developer';

import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/get_mandates_params.dart';
import '../models/get_mandates_response.dart';
import '../models/login_pam_account_params.dart';
import '../models/login_pam_account_response.dart';
import '../models/mandate_param.dart';

abstract class PamLoginRemoteDataSource {
  Future<GetMandatesResponse> getMandates(GetMandatesParams params);
  Future<LoginPamAccountResponse> loginPamAccount(List<Mandate> params);
}

class PamLoginRemoteDataSourceImpl extends AppServerDataSource
    implements PamLoginRemoteDataSource {
  PamLoginRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<GetMandatesResponse> getMandates(GetMandatesParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.get, AppUrls.getMandate, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = GetMandatesResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception + $e",
          type: ExceptionType.format,
          data: e.toString(),
          stackTrace: e is TypeError ? e.stackTrace.toString() : null);
    }
  }

  @override
  Future<LoginPamAccountResponse> loginPamAccount(List<Mandate> params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.get, AppUrls.postMandates, jsonEncode(params));
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = LoginPamAccountResponse.fromJson(response);
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
