import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/add_assets/add_private_debt/data/models/private_debt_save_response_model.dart';
import 'package:wmd/features/add_assets/add_private_debt/domain/use_cases/add_private_debt_usecase.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';

abstract class PrivateDebtSaveRemoteDataSource {
  Future<AddAssetModel> postPrivateDebt(
      AddPrivateDebtParams privateDebtSaveParams);
}

class PrivateDebtSaveRemoteDataSourceImpl extends AppServerDataSource
    implements PrivateDebtSaveRemoteDataSource {
  PrivateDebtSaveRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<AddAssetModel> postPrivateDebt(
      AddPrivateDebtParams addPrivateDebtParams) async {
    final tPostPrivateDebtSaveRequestOptions = AppRequestOptions(
        RequestTypes.post,
        AppUrls.postBankDetails,
        addPrivateDebtParams.toJson());

    final response = await errorHandlerMiddleware
        .sendRequest(tPostPrivateDebtSaveRequestOptions);
    final result = AddAssetModel.fromJson(response);

    return result;
  }
}
