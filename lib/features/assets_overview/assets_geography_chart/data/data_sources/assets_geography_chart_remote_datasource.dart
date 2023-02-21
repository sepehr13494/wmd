import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/get_assets_geography_params.dart';
import '../models/get_assets_geography_response.dart';



abstract class AssetsGeographyChartRemoteDataSource {
  Future<List<GetAssetsGeographyResponse>> getAssetsGeography(GetAssetsGeographyParams params);

}

class AssetsGeographyChartRemoteDataSourceImpl extends AppServerDataSource
    implements AssetsGeographyChartRemoteDataSource {
  AssetsGeographyChartRemoteDataSourceImpl(super.errorHandlerMiddleware);
  
    @override
  Future<List<GetAssetsGeographyResponse>> getAssetsGeography(GetAssetsGeographyParams params) async {
    try{
      final appRequestOptions =
          AppRequestOptions(RequestTypes.get, AppUrls.getAssetsGeography, params.toJson());
      final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = (response as List<dynamic>)
                  .map((e) => GetAssetsGeographyResponse.fromJson(e))
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
