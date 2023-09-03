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

abstract class AssetValuationRemoteDataSource {
  Future<void> postValuation(PostValuationParams params);
  Future<void> updateValuation(UpdateValuationParams params);
  Future<void> deleteValuation(GetValuationParams params);
  Future<GetValuationResponse> getValuationById(GetValuationParams params);
}

class AssetValuationRemoteDataSourceImpl extends AppServerDataSource
    implements AssetValuationRemoteDataSource {
  AssetValuationRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<void> postValuation(PostValuationParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(RequestTypes.post,
          AppUrls.postAddValuation, params.toValuationJson());
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
  Future<void> updateValuation(UpdateValuationParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.put, AppUrls.postAddValuation, params.toValuationJson());
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
  Future<void> deleteValuation(GetValuationParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(RequestTypes.delete,
          AppUrls.postAddValuation, params.toValuationJson());
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
  Future<GetValuationResponse> getValuationById(
      GetValuationParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.get, AppUrls.postAddValuation, params.toValuationJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = GetValuationResponse.fromValuationJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }
}
