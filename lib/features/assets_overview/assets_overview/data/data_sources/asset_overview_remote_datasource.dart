import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/assets_overview_params.dart';
import '../models/assets_overview_response.dart';

abstract class AssetsOverviewRemoteDataSource {
  Future<List<AssetsOverviewResponse>> getAssetsOverview(AssetsOverviewParams params);
}

class AssetsOverviewRemoteDataSourceImpl extends AppServerDataSource
    implements AssetsOverviewRemoteDataSource {
  AssetsOverviewRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<List<AssetsOverviewResponse>> getAssetsOverview(AssetsOverviewParams params) async {
    try{
      final appRequestOptions1 = AppRequestOptions(RequestTypes.get, AppUrls.getAssetsOverviewByType, params.toJson());
      final appRequestOptions2 = AppRequestOptions(RequestTypes.get, AppUrls.getAssetsByType, params.toJson());
      late Map<String,dynamic> response1;
      late List<dynamic> response2;
      await Future.wait([
        errorHandlerMiddleware.sendRequest(appRequestOptions1).then((value) {
          response1 = value;
        }),
        errorHandlerMiddleware.sendRequest(appRequestOptions2).then((value) {
          response2 = value;
        }),
      ]);
      final response = {
        ...response1,
        "assetList":response2
      };
      final result = [AssetsOverviewResponse.fromJson(response)];
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format,data: e.toString(),stackTrace: e is TypeError ? e.stackTrace.toString() : null);
    }

  }
}

