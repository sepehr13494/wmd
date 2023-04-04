import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/post_valuation_params.dart';
import '../models/post_valuation_response.dart';
import '../models/update_valuation_params.dart';
import '../models/update_valuation_response.dart';

abstract class AssetValuationRemoteDataSource {
  Future<void> postValuation(PostValuationParams params);
  Future<UpdateValuationResponse> updateValuation(UpdateValuationParams params);
}

class AssetValuationRemoteDataSourceImpl extends AppServerDataSource
    implements AssetValuationRemoteDataSource {
  AssetValuationRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<void> postValuation(PostValuationParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.post, AppUrls.postAddValuation, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);

      return;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }

  @override
  Future<UpdateValuationResponse> updateValuation(
      UpdateValuationParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.put, AppUrls.postAddValuation, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = UpdateValuationResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format);
    }
  }
}