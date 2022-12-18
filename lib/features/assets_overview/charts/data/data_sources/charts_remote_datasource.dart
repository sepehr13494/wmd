import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/get_chart_params.dart';
import '../models/get_chart_response.dart';



abstract class ChartsRemoteDataSource {
  Future<List<GetChartResponse>> getChart(GetChartParams params);

}

class ChartsRemoteDataSourceImpl extends AppServerDataSource
    implements ChartsRemoteDataSource {
  ChartsRemoteDataSourceImpl(super.errorHandlerMiddleware);
  
    @override
  Future<List<GetChartResponse>> getChart(GetChartParams params) async {
    try{
      final appRequestOptions =
          AppRequestOptions(RequestTypes.get, "${AppUrls.getChart}/${params.userid}/history", {
            "To":params.to
          });
      final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = (response as List<dynamic>)
                  .map((e) => GetChartResponse.fromJson(e))
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
