import 'dart:developer';

import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/delete_custodian_bank_status_params.dart';

import '../models/get_linked_accounts_params.dart';
import '../models/get_linked_accounts_response.dart';

abstract class LinkedAccountsRemoteDataSource {
  Future<List<GetLinkedAccountsResponse>> getLinkedAccounts(
      GetLinkedAccountsParams params);
  Future<void> deleteLinkedAccounts(DeleteCustodianBankStatusParams params);
}

class LinkedAccountsRemoteDataSourceImpl extends AppServerDataSource
    implements LinkedAccountsRemoteDataSource {
  LinkedAccountsRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<List<GetLinkedAccountsResponse>> getLinkedAccounts(
      GetLinkedAccountsParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.get, AppUrls.getLinkedAccounts, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = (response as List<dynamic>)
          .map((e) => GetLinkedAccountsResponse.fromJson(e))
          .toList();
      log('Mert log : $result');
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
  Future<void> deleteLinkedAccounts(DeleteCustodianBankStatusParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.del, AppUrls.custodianBank, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      // final result = GetCustodianBankStatusResponse.fromJson(response);
      return;
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
