import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/data/models/bank_save_response_model.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/use_cases/post_bank_details_usecase.dart';

abstract class BankSaveRemoteDataSource {
  Future<BankSaveResponseModel> postBankDetails(BankSaveParams bankSaveParams);
}

class BankSaveRemoteDataSourceImpl extends AppServerDataSource
    implements BankSaveRemoteDataSource {
  BankSaveRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<BankSaveResponseModel> postBankDetails(
      BankSaveParams bankSaveParams) async {
    final tPostBankSaveRequestOptions = AppRequestOptions(
        RequestTypes.post, AppUrls.postBankDetails, bankSaveParams.toJson());
    final response =
        await errorHandlerMiddleware.sendRequest(tPostBankSaveRequestOptions);
    final result = BankSaveResponseModel.fromJson(response);
    return result;
  }
}
