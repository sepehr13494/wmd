import 'package:flutter/material.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/data/models/get_market_data_params.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/data/models/get_market_data_response.dart';

import '../models/bank_list_response.dart';

abstract class BankListRemoteDataSource {
  Future<List<BankResponse>> getBankList(NoParams param);
  Future<List<BankResponse>> getPopularBankList(int? count);
  Future<List<GetMarketDataResponse>> getMarketData(GetMarketDataParams params);
}

class BankListRemoteDataSourceImpl extends AppServerDataSource
    implements BankListRemoteDataSource {
  BankListRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<List<BankResponse>> getBankList(NoParams param) async {
    final getBankListRequestOptions =
        AppRequestOptions(RequestTypes.get, AppUrls.getBankList, null);
    final List<dynamic> response =
        await errorHandlerMiddleware.sendRequest(getBankListRequestOptions);
    try {
      return response.map((e) => BankResponse.fromJson(e)).toList();
    } catch (e) {
      throw const AppException(
          message: 'Format exceptions', type: ExceptionType.format);
    }
  }

  @override
  Future<List<BankResponse>> getPopularBankList(int? count) async {
    final getPopularBankListRequestOptions = AppRequestOptions(
        RequestTypes.get,
        AppUrls.getPopularBankList,
        count == null
            ? null
            : {
                'count': count,
              });
    final List<dynamic> response = await errorHandlerMiddleware
        .sendRequest(getPopularBankListRequestOptions);
    try {
      return response.map((e) => BankResponse.fromJson(e)).toList();
    } catch (e) {
      throw const AppException(
          message: 'Format exceptions', type: ExceptionType.format);
    }
  }

  @override
  Future<List<GetMarketDataResponse>> getMarketData(
      GetMarketDataParams params) async {
    try {
    final getPopularBankListRequestOptions = AppRequestOptions(
        RequestTypes.get, AppUrls.getMarketData, params.toJson());
    final List<dynamic> response = await errorHandlerMiddleware
        .sendRequest(getPopularBankListRequestOptions);

    return response.map((e) => GetMarketDataResponse.fromJson(e)).toList();
    } catch (e) {
      throw const AppException(
          message: 'Format exceptions', type: ExceptionType.format);
    }
  }
}
