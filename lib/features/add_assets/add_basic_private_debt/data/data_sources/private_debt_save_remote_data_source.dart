import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/add_assets/add_basic_private_debt/data/models/private_debt_save_response_model.dart';
import 'package:wmd/features/add_assets/add_basic_private_debt/domain/use_cases/post_private_debt_usecase.dart';

abstract class PrivateDebtSaveRemoteDataSource {
  Future<PrivateDebtSaveResponseModel> postPrivateDebt(
      PrivateDebtSaveParams privateDebtSaveParams);
}

class PrivateDebtSaveRemoteDataSourceImpl extends AppServerDataSource
    implements PrivateDebtSaveRemoteDataSource {
  PrivateDebtSaveRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<PrivateDebtSaveResponseModel> postPrivateDebt(
      PrivateDebtSaveParams privateDebtSaveParams) async {
    final tPostPrivateDebtSaveRequestOptions = AppRequestOptions(
        RequestTypes.post,
        AppUrls.postBankDetails,
        privateDebtSaveParams.toJson());

    final response = await errorHandlerMiddleware
        .sendRequest(tPostPrivateDebtSaveRequestOptions);
    final result = PrivateDebtSaveResponseModel.fromJson(response);

    return result;
  }
}
