import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/request_new_custodian_params.dart';
import '../models/request_new_custodian_response.dart';

abstract class RequestNewCustodianRemoteDataSource {
  Future<RequestNewCustodianResponse> requestNewCustodian(
      RequestNewCustodianParams params);
}

class RequestNewCustodianRemoteDataSourceImpl extends AppServerDataSource
    implements RequestNewCustodianRemoteDataSource {
  RequestNewCustodianRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<RequestNewCustodianResponse> requestNewCustodian(
      RequestNewCustodianParams params) async {
    try {
      final appRequestOptions = AppRequestOptions(
          RequestTypes.post, AppUrls.requestNewCustodian, params.toJson());
      final response =
          await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = RequestNewCustodianResponse();
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
