import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/get_liablility_overview_params.dart';
import '../models/get_liablility_overview_response.dart';



abstract class LiablilityOverviewRemoteDataSource {
  Future<List<GetLiablilityOverviewResponse>> getLiablilityOverview(GetLiablilityOverviewParams params);

}

class LiablilityOverviewRemoteDataSourceImpl extends AppServerDataSource
    implements LiablilityOverviewRemoteDataSource {
  LiablilityOverviewRemoteDataSourceImpl(super.errorHandlerMiddleware);
  
    @override
  Future<List<GetLiablilityOverviewResponse>> getLiablilityOverview(GetLiablilityOverviewParams params) async {
    try{
      final appRequestOptions =
          AppRequestOptions(RequestTypes.get, AppUrls.getLiablilityOverview, params.toJson());
      final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = (response as List<dynamic>)
                  .map((e) => GetLiablilityOverviewResponse.fromJson(e))
                  .toList();
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format,data: e.toString(),stackTrace: e is TypeError ? e.stackTrace.toString() : null);
    }
  }
  
    
}
