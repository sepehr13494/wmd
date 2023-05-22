import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/get_liablility_overview_params.dart';
import '../models/get_liablility_overview_response.dart';

abstract class LiabilityOverviewRemoteDataSource {
  Future<List<GetLiabilityOverviewResponse>> getLiablilityOverview(
      GetLiabilityOverviewParams params);
}

class LiabilityOverviewRemoteDataSourceImpl extends AppServerDataSource
    implements LiabilityOverviewRemoteDataSource {
  LiabilityOverviewRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<List<GetLiabilityOverviewResponse>> getLiablilityOverview(
      GetLiabilityOverviewParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.get, AppUrls.getLiablilityOverview, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = (response as List<dynamic>)
          .map((e) => GetLiabilityOverviewResponse.fromJson(e))
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
