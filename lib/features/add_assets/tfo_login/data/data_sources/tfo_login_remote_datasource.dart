import 'dart:developer';

import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/get_mandates_params.dart';
import '../models/get_mandates_response.dart';
import '../models/login_tfo_account_params.dart';
import '../models/login_tfo_account_response.dart';

abstract class TfoLoginRemoteDataSource {
  Future<GetMandatesResponse> getMandates(GetMandatesParams params);
  Future<LoginTfoAccountResponse> loginTfoAccount(LoginTfoAccountParams params);
}

class TfoLoginRemoteDataSourceImpl extends AppServerDataSource
    implements TfoLoginRemoteDataSource {
  TfoLoginRemoteDataSourceImpl(super.errorHandlerMiddleware);

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
  Future<LoginTfoAccountResponse> loginTfoAccount(
      LoginTfoAccountParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.get, AppUrls.postMandates, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = LoginTfoAccountResponse.fromJson(response);
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
