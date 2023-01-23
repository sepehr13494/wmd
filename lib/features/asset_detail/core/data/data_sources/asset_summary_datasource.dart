import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/asset_detail/core/data/models/get_summary_response.dart';
import '../models/get_summary_params.dart';

abstract class AssetSummaryRemoteDataSource {
  Future<AssetSummaryResponse> getSummary(GetSummaryParams params);
}

class AssetSummaryRemoteDataSourceImpl extends AppServerDataSource
    implements AssetSummaryRemoteDataSource {
  AssetSummaryRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<AssetSummaryResponse> getSummary(GetSummaryParams params) async {
    final appRequestOptions = AppRequestOptions(
        RequestTypes.get, AppUrls.getAssetSummary(params.assetId), {
      'to': DateTime.now().toIso8601String(),
      'from': DateTime.now()
          .subtract(Duration(days: params.days))
          .toIso8601String(),
    });
    final response =
        await errorHandlerMiddleware.sendRequest(appRequestOptions);
    return AssetSummaryResponse.fromJson(response);
  }
}
