import 'package:flutter/material.dart';
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
    final getBankListRequestOptions =
        AppRequestOptions(RequestTypes.get, AppUrls.getBankList, null);
    final response = await errorHandlerMiddleware
        .sendRequestType<List<dynamic>>(getBankListRequestOptions);
    return response.map((e) => BankResponse.fromJson(e)).toList();
  }

  @override
  Future<List<BankResponse>> getPopularBankList(NoParams param) async {
    final getBankListRequestOptions =
        AppRequestOptions(RequestTypes.get, AppUrls.getPopularBankList, null);
    final response = await errorHandlerMiddleware
        .sendRequestType<List<dynamic>>(getBankListRequestOptions);
    return response.map((e) => BankResponse.fromJson(e)).toList();
  }
}
