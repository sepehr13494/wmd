import 'package:flutter/material.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/get_asset_class_params.dart';
import '../models/get_asset_class_response.dart';
import '../models/get_benchmark_params.dart';
import '../models/get_benchmark_response.dart';
import '../models/get_custodian_performance_params.dart';
import '../models/get_custodian_performance_response.dart';

abstract class PerformanceTableRemoteDataSource {
  Future<List<GetAssetClassResponse>> getAssetClass(GetAssetClassParams params);
  Future<List<GetBenchmarkResponse>> getBenchmark(GetBenchmarkParams params);
  Future<List<GetCustodianPerformanceResponse>> getCustodianPerformance(
      GetCustodianPerformanceParams params);
}

class PerformanceTableRemoteDataSourceImpl extends AppServerDataSource
    implements PerformanceTableRemoteDataSource {
  PerformanceTableRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<List<GetAssetClassResponse>> getAssetClass(
      GetAssetClassParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.get, AppUrls.getAssetClass, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);

      // handle status 204
      if (response == "") {
        return [];
      }

      final result = (response["assetClassPerformance"] as List<dynamic>)
          .map((e) => GetAssetClassResponse.fromJson(e))
          .toList();
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
  Future<List<GetBenchmarkResponse>> getBenchmark(
      GetBenchmarkParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.get, AppUrls.getBenchmark, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = (response as List<dynamic>)
          .map((e) => GetBenchmarkResponse.fromJson(e))
          .toList();
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
  Future<List<GetCustodianPerformanceResponse>> getCustodianPerformance(
      GetCustodianPerformanceParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.get, AppUrls.getCustodianPerformance, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = (response as List<dynamic>)
          .map((e) => GetCustodianPerformanceResponse.fromJson(e))
          .toList();
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
