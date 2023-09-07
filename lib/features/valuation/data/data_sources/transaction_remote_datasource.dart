import 'package:flutter/material.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/valuation/data/models/get_valuation_params.dart';
import 'package:wmd/features/valuation/data/models/get_valuation_response.dart';

import '../models/post_valuation_params.dart';
import '../models/update_valuation_params.dart';
import '../models/update_valuation_response.dart';

abstract class AssetTransactionRemoteDataSource {
  Future<void> postTransaction(PostValuationParams params);
  Future<void> updateTransaction(UpdateValuationParams params);
  Future<void> deleteTransaction(GetValuationParams params);
  Future<GetValuationResponse> getTransactionById(GetValuationParams params);
}

class AssetTransactionRemoteDataSourceImpl extends AppServerDataSource
    implements AssetTransactionRemoteDataSource {
  AssetTransactionRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<void> postTransaction(PostValuationParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.post, AppUrls.postAddTransaction, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);

      return;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }

  @override
  Future<void> updateTransaction(UpdateValuationParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.put, AppUrls.postAddTransaction, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);

      return;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }

  @override
  Future<void> deleteTransaction(GetValuationParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.del, AppUrls.postAddTransaction, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);

      return;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }

  @override
  Future<GetValuationResponse> getTransactionById(
      GetValuationParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.get, AppUrls.postAddTransaction, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = GetValuationResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }
}
