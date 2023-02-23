import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/data/repository/app_data_source.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/delete_custodian_bank_status_params.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/put_custodian_bank_status_params.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/status_response.dart';

import '../models/get_custodian_bank_list_params.dart';
import '../models/custodian_bank_response.dart';
import '../models/post_custodian_bank_status_params.dart';
import '../models/post_custodian_bank_status_response.dart';
import '../models/get_custodian_bank_status_params.dart';
import '../models/get_custodian_bank_status_response.dart';

abstract class CustodianBankAuthRemoteDataSource {
  Future<List<CustodianBankResponse>> getCustodianBankList(
      GetCustodianBankListParams params);
  Future<PostCustodianBankStatusResponse> postCustodianBankStatus(
      PostCustodianBankStatusParams params);
  Future<PostCustodianBankStatusResponse> putCustodianBankStatus(
      PutCustodianBankStatusParams params);
  Future<GetCustodianBankStatusResponse> getCustodianBankStatus(
      GetCustodianBankStatusParams params);
  Future<void> deleteCustodianBankStatus(
      DeleteCustodianBankStatusParams params);
  Future<List<StatusResponse>> getStatusList(GetCustodianBankListParams params);
}

class CustodianBankAuthRemoteDataSourceImpl extends AppServerDataSource
    implements CustodianBankAuthRemoteDataSource {
  CustodianBankAuthRemoteDataSourceImpl(super.errorHandlerMiddleware);

  @override
  Future<List<CustodianBankResponse>> getCustodianBankList(
      GetCustodianBankListParams params) async {
    final appRequestOptions = AppRequestOptions(
        RequestTypes.get, AppUrls.getCustodianBankList, params.toJson());
    final response =
        await errorHandlerMiddleware.sendRequest(appRequestOptions);
    final result = (response as List<dynamic>)
        .map((e) => CustodianBankResponse.fromJson(e))
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
    return PostCustodianBankStatusResponse(id: response['id']);
  }

  @override
  Future<PostCustodianBankStatusResponse> putCustodianBankStatus(
      PutCustodianBankStatusParams params) async {
    final appRequestOptions = AppRequestOptions(
        RequestTypes.put, AppUrls.custodianBank, params.toJson());
    final response =
        await errorHandlerMiddleware.sendRequest(appRequestOptions);
    return PostCustodianBankStatusResponse(id: response['id']);
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

  @override
  Future<void> deleteCustodianBankStatus(
      DeleteCustodianBankStatusParams params) async {
    final appRequestOptions = AppRequestOptions(
        RequestTypes.del, AppUrls.custodianBank, params.toJson());
    final response =
        await errorHandlerMiddleware.sendRequest(appRequestOptions);
    // final result = GetCustodianBankStatusResponse.fromJson(response);
    return;
  }

  @override
  Future<List<StatusResponse>> getStatusList(
      GetCustodianBankListParams params) async {
    final appRequestOptions = AppRequestOptions(
        RequestTypes.get, AppUrls.getCustodianStatusList, params.toJson());
    final response =
        await errorHandlerMiddleware.sendRequest(appRequestOptions);
    final result = (response as List<dynamic>)
        .map((e) => StatusResponse.fromJson(e))
        .toList();
    return result;
  }
}
