import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/put_loan_liability_params.dart';
import '../models/put_loan_liability_response.dart';
import '../models/delete_loan_liability_params.dart';
import '../models/delete_loan_liability_response.dart';



abstract class EditLoanLiabilityRemoteDataSource {
  Future<PutLoanLiabilityResponse> putLoanLiability(PutLoanLiabilityParams params);
  Future<DeleteLoanLiabilityResponse> deleteLoanLiability(DeleteLoanLiabilityParams params);

}

class EditLoanLiabilityRemoteDataSourceImpl extends AppServerDataSource
    implements EditLoanLiabilityRemoteDataSource {
  EditLoanLiabilityRemoteDataSourceImpl(super.errorHandlerMiddleware);
  
    @override
  Future<PutLoanLiabilityResponse> putLoanLiability(PutLoanLiabilityParams params) async {
    try{
      final appRequestOptions =
          AppRequestOptions(RequestTypes.get, AppUrls.putLoanLiability, params.toJson());
      final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = PutLoanLiabilityResponse();
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format,data: e.toString(),stackTrace: e is TypeError ? e.stackTrace.toString() : null);
    }
  }
  
      @override
  Future<DeleteLoanLiabilityResponse> deleteLoanLiability(DeleteLoanLiabilityParams params) async {
    try{
      final appRequestOptions =
          AppRequestOptions(RequestTypes.get, AppUrls.deleteLoanLiability, params.toJson());
      final response = await errorHandlerMiddleware.sendRequest(appRequestOptions);
      final result = DeleteLoanLiabilityResponse();
      return result;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw AppException(
          message: "format Exception", type: ExceptionType.format,data: e.toString(),stackTrace: e is TypeError ? e.stackTrace.toString() : null);
    }
  }
  
    
}
