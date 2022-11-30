import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/bank_account_params.dart';
import '../models/bank_account_response.dart';

abstract class BankAccountRemoteDataSource {
  Future<BankAccountResponse> getBankAccount(BankAccountParams params);
}

class BankAccountRemoteDataSourceImpl extends AppServerDataSource
    implements BankAccountRemoteDataSource {
  BankAccountRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<BankAccountResponse> getBankAccount(BankAccountParams params) async {
    final url = Uri.parse(AppUrls.getBankAccount)
        .replace(queryParameters: {'assetId': params.assetId});
    final appRequestOptions =
        AppRequestOptions(RequestTypes.get, url.toString(), params.toJson());
    final response =
        await errorHandlerMiddleware.sendRequest(appRequestOptions);

    return BankAccountResponse.fromJson(response);
  }
}
