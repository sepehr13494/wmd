import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/put_bank_manual_params.dart';
import '../models/put_bank_manual_response.dart';
import '../models/delete_bank_manual_params.dart';
import '../models/delete_bank_manual_response.dart';



abstract class EditBankManualRemoteDataSource {
  Future<PutBankManualResponse> putBankManual(PutBankManualParams params);
  Future<DeleteBankManualResponse> deleteBankManual(DeleteBankManualParams params);

}

class EditBankManualRemoteDataSourceImpl extends AppServerDataSource
    implements EditBankManualRemoteDataSource {
  EditBankManualRemoteDataSourceImpl(super.errorHandlerMiddleware);
  
    @override
  Future<PutBankManualResponse> putBankManual(PutBankManualParams params) async {
    try{
      final appRequestOptions =
          AppRequestOptions(RequestTypes.put, AppUrls.putBankManual, params.toServerJson());
      final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = PutBankManualResponse.fromJson(response);
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format,data: e.toString(),stackTrace: e is TypeError ? e.stackTrace.toString() : null);
    }
  }
  
      @override
  Future<DeleteBankManualResponse> deleteBankManual(DeleteBankManualParams params) async {
    try{
      final appRequestOptions =
          AppRequestOptions(RequestTypes.del, AppUrls.deleteBankManual, params.toJson());
      final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = DeleteBankManualResponse();
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format,data: e.toString(),stackTrace: e is TypeError ? e.stackTrace.toString() : null);
    }
  }
  
    
}
