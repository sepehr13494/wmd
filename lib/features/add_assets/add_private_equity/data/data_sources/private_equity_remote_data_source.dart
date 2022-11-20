import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/add_assets/add_private_equity/domain/use_cases/add_private_equity_usecase.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';

abstract class PrivateEquityRemoteDataSource {
  Future<AddAssetModel> postPrivateEquityDetails(
      AddPrivateEquityParams addPrivateEquityParams);
}

class PrivateEquityRemoteDataSourceImpl extends AppServerDataSource
    implements PrivateEquityRemoteDataSource {
  PrivateEquityRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<AddAssetModel> postPrivateEquityDetails(
      AddPrivateEquityParams addPrivateEquityParams) async {
    final tPostBankSaveRequestOptions = AppRequestOptions(
        RequestTypes.post, AppUrls.postPrivateEquity, addPrivateEquityParams);
    final response =
        await errorHandlerMiddleware.sendRequest(tPostBankSaveRequestOptions);
    final result = AddAssetModel.fromJson(response);
    return result;
  }
}
