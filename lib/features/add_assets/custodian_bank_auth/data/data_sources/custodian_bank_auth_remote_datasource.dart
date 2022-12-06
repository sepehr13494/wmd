import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/models/app_request_options.dart';

import '../models/get_custodian_bank_list_params.dart';
import '../models/get_custodian_bank_list_response.dart';
import '../models/post_custodian_bank_status_params.dart';
import '../models/post_custodian_bank_status_response.dart';
import '../models/get_custodian_bank_status_params.dart';
import '../models/get_custodian_bank_status_response.dart';

abstract class CustodianBankAuthRemoteDataSource {
  Future<List<GetCustodianBankListResponse>> getCustodianBankList(
      GetCustodianBankListParams params);
  Future<PostCustodianBankStatusResponse> postCustodianBankStatus(
      PostCustodianBankStatusParams params);
  Future<GetCustodianBankStatusResponse> getCustodianBankStatus(
      GetCustodianBankStatusParams params);
}

class CustodianBankAuthRemoteDataSourceImpl extends AppServerDataSource
    implements CustodianBankAuthRemoteDataSource {
  CustodianBankAuthRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<List<GetCustodianBankListResponse>> getCustodianBankList(
      GetCustodianBankListParams params) async {
    final appRequestOptions = AppRequestOptions(
        RequestTypes.get, AppUrls.getCustodianBankList, params.toJson());
    final response =
        await errorHandlerMiddleware.sendRequest(appRequestOptions);
    final result = (response as List<dynamic>)
        .map((e) => GetCustodianBankListResponse.fromJson(e))
        .toList();
    return result;
  }

  @override
  Future<PostCustodianBankStatusResponse> postCustodianBankStatus(
      PostCustodianBankStatusParams params) async {
    final appRequestOptions = AppRequestOptions(
        RequestTypes.post, AppUrls.custodianBank, params.toJson());
    final response =
        await errorHandlerMiddleware.sendRequest(appRequestOptions);
    final result = PostCustodianBankStatusResponse.fromJson(response);
    return result;
  }

  @override
  Future<GetCustodianBankStatusResponse> getCustodianBankStatus(
      GetCustodianBankStatusParams params) async {
    final appRequestOptions = AppRequestOptions(
        RequestTypes.get, AppUrls.custodianBank, params.toJson());
    final response =
        await errorHandlerMiddleware.sendRequest(appRequestOptions);
    final result = GetCustodianBankStatusResponse.fromJson(response);
    return result;
  }
}
