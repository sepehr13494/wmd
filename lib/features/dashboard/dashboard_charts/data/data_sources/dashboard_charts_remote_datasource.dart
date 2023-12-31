import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/get_allocation_params.dart';
import '../models/get_allocation_response.dart';
import '../models/get_geographic_params.dart';
import '../models/get_geographic_response.dart';
import '../models/get_pie_params.dart';
import '../models/get_pie_response.dart';

abstract class DashboardChartsRemoteDataSource {
  Future<List<GetAllocationResponse>> getAllocation(GetAllocationParams params);

  Future<List<GetGeographicResponse>> getGeographic(GetGeographicParams params);

  Future<List<GetPieResponse>> getPie(GetPieParams params);
}

class DashboardChartsRemoteDataSourceImpl extends AppServerDataSource
    implements DashboardChartsRemoteDataSource {
  DashboardChartsRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<List<GetAllocationResponse>> getAllocation(
      GetAllocationParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(RequestTypes.get,
          "${AppUrls.getAllocation}${params.ownerId}/history", {
        "from": params.from,
        "To":params.to,
      });
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = (response as List<dynamic>)
          .map((e) => GetAllocationResponse.fromJson(e))
          .toList();
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }

  @override
  Future<List<GetGeographicResponse>> getGeographic(
      GetGeographicParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.get, AppUrls.getGeographic, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = (response as List<dynamic>)
          .map((e) => GetGeographicResponse.fromJson(e))
          .toList();
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }

  @override
  Future<List<GetPieResponse>> getPie(GetPieParams params) async {
    try {
      final appRequestOptions =
          AppRequestOptions(RequestTypes.get, AppUrls.getPie, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = (response as List<dynamic>)
          .map((e) => GetPieResponse.fromJson(e))
          .toList();
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }
}
