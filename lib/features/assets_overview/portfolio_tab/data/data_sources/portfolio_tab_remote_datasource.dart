import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/get_portfolio_tab_params.dart';
import '../models/get_portfolio_tab_response.dart';



abstract class PortfolioTabRemoteDataSource {
  Future<List<GetPortfolioTabResponse>> getPortfolioTab(GetPortfolioTabParams params);

}

class PortfolioTabRemoteDataSourceImpl extends AppServerDataSource
    implements PortfolioTabRemoteDataSource {
  PortfolioTabRemoteDataSourceImpl(super.errorHandlerMiddleware);
  
    @override
  Future<List<GetPortfolioTabResponse>> getPortfolioTab(GetPortfolioTabParams params) async {
      await Future.delayed(Duration(seconds: 1));
      return GetPortfolioTabResponse.tResponse;
    try{
      final appRequestOptions =
          AppRequestOptions(RequestTypes.get, AppUrls.getPortfolioTab, params.toJson());
      final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = (response as List<dynamic>)
                  .map((e) => GetPortfolioTabResponse.fromJson(e))
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
