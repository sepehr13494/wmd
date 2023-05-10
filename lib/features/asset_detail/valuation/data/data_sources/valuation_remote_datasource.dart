import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/models/app_request_options.dart';
import '../models/get_all_valuation_params.dart';
import '../models/get_all_valuation_response.dart';
import '../models/get_valuation_performance_response.dart';
import '../models/post_valuation_params.dart';
import '../models/post_valuation_response.dart';
import '../models/get_valuation_performance_params.dart';

abstract class ValuationRemoteDataSource {
  Future<List<GetAllValuationResponse>> getAllValuation(
      GetAllValuationParams params);
  Future<PostValuationResponse> postValuation(PostValuationParams params);
  Future<GetValuationPerformanceResponse> getValuationPerformance(
      GetValuationPerformanceParams params);
}

class ValuationRemoteDataSourceImpl extends AppServerDataSource
    implements ValuationRemoteDataSource {
  ValuationRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<List<GetAllValuationResponse>> getAllValuation(
      GetAllValuationParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.get, AppUrls.getAllValuation, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = (response as List<dynamic>)
          .map((e) => GetAllValuationResponse.fromJson(e))
          .toList();
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format, data: e);
    }
  }

  @override
  Future<PostValuationResponse> postValuation(
      PostValuationParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.get, AppUrls.postValuation, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = PostValuationResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }

  @override
  Future<GetValuationPerformanceResponse> getValuationPerformance(
      GetValuationPerformanceParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.get, AppUrls.getValuationPerformance(params.id), {
        'to': DateFormat("yyyy-MM-dd").format(DateTime.now()),
        'from': DateFormat("yyyy-MM-dd")
            .format(DateTime.now().subtract(Duration(days: params.days))),
      });
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      return GetValuationPerformanceResponse.fromJson(response);
    } on ServerException {
      rethrow;
    } catch (e) {
      log(e.toString());
      throw const AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }
}
