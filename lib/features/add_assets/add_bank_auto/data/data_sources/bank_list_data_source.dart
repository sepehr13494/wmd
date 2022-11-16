import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/bank_list_response.dart';

abstract class BankListRemoteDataSource {
  Future<List<BankResponse>> getBankList(NoParams param);
  Future<List<BankResponse>> getPopularBankList(NoParams param);
}

class BankListRemoteDataSourceImpl extends AppServerDataSource
    implements BankListRemoteDataSource {
  BankListRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<List<BankResponse>> getBankList(NoParams param) async {
    // final getBankListRequestOptions =
    //     AppRequestOptions(RequestTypes.post, AppUrls.getBankList, param);
    // final response =
    //     await errorHandlerMiddleware.sendRequest(getBankListRequestOptions);
    return const [
      BankResponse(code: 'akb', name: 'Akbanks'),
      BankResponse(code: 'isb', name: 'Is Banks'),
      BankResponse(code: 'qnb', name: 'Finans QNB'),
      BankResponse(code: 'grn', name: 'Garanti'),
    ];
  }

  @override
  Future<List<BankResponse>> getPopularBankList(NoParams param) async {
    // final getBankListRequestOptions =
    //     AppRequestOptions(RequestTypes.post, AppUrls.getPopularBankList, param);
    // final response =
    //     await errorHandlerMiddleware.sendRequest(getBankListRequestOptions);
    return const [
      BankResponse(code: 'akb', name: 'Akbanks'),
      BankResponse(code: 'isb', name: 'Is Banks'),
      BankResponse(code: 'qnb', name: 'Finans QNB'),
      BankResponse(code: 'grn', name: 'Garanti'),
    ];
  }
}
