import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/put_private_debt_params.dart';
import '../models/put_private_debt_response.dart';
import '../models/delete_private_debt_params.dart';
import '../models/delete_private_debt_response.dart';



abstract class EditPrivateDebtRemoteDataSource {
  Future<PutPrivateDebtResponse> putPrivateDebt(PutPrivateDebtParams params);
  Future<DeletePrivateDebtResponse> deletePrivateDebt(DeletePrivateDebtParams params);

}

class EditPrivateDebtRemoteDataSourceImpl extends AppServerDataSource
    implements EditPrivateDebtRemoteDataSource {
  EditPrivateDebtRemoteDataSourceImpl(super.errorHandlerMiddleware);
  
    @override
  Future<PutPrivateDebtResponse> putPrivateDebt(PutPrivateDebtParams params) async {
    try{
      final appRequestOptions =
          AppRequestOptions(RequestTypes.put, AppUrls.putPrivateDebt, params.toServerJson());
      final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = PutPrivateDebtResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format,data: e.toString(),stackTrace: e is TypeError ? e.stackTrace.toString() : null);
    }
  }
  
      @override
  Future<DeletePrivateDebtResponse> deletePrivateDebt(DeletePrivateDebtParams params) async {
    try{
      final appRequestOptions =
          AppRequestOptions(RequestTypes.del, AppUrls.deletePrivateDebt, params.toJson());
      final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = DeletePrivateDebtResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format,data: e.toString(),stackTrace: e is TypeError ? e.stackTrace.toString() : null);
    }
  }
  
    
}
