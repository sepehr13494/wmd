import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
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
    final appRequestOptions =
        AppRequestOptions(RequestTypes.get, AppUrls.getAssetsOverview, params.toJson());
    final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
    final result = (response as List<dynamic>)
                .map((e) => AssetsOverviewResponse.fromJson(e))
                .toList();
    return result;
  }
}
