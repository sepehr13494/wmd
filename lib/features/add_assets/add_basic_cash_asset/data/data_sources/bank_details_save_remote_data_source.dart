import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/use_cases/post_bank_details_usecase.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';

abstract class BankSaveRemoteDataSource {
  Future<AddAssetModel> postBankDetails(BankSaveParams bankSaveParams);
}

class BankSaveRemoteDataSourceImpl extends AppServerDataSource
    implements BankSaveRemoteDataSource {
  BankSaveRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<AddAssetModel> postBankDetails(BankSaveParams bankSaveParams) async {
    final tPostBankSaveRequestOptions = AppRequestOptions(
        RequestTypes.post, AppUrls.postBankDetails, bankSaveParams.toJson());
    final response =
        await errorHandlerMiddleware.sendRequest(tPostBankSaveRequestOptions);
    final result = AddAssetModel.fromJson(response);
    return result;
  }
}
