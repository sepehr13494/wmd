import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/get_currency_params.dart';
import '../models/get_currency_response.dart';

abstract class CurrencyRemoteDataSource {
  Future<GetCurrencyConversionResponse> getCurrency(
      GetCurrencyConversionParams params);
}

class CurrencyRemoteDataSourceImpl extends AppServerDataSource
    implements CurrencyRemoteDataSource {
  CurrencyRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<GetCurrencyConversionResponse> getCurrency(
      GetCurrencyConversionParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.get, AppUrls.getCurrencyConversion, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = GetCurrencyConversionResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }
}
