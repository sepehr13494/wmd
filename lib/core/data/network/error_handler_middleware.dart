import 'dart:developer';
import 'package:check_vpn_connection/check_vpn_connection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/data/network/check_network_change.dart';
import 'package:wmd/core/util/constants.dart';
import 'package:wmd/injection_container.dart';
import 'server_request_manager.dart';
import 'urls.dart';
import '../../error_and_success/exeptions.dart';
import '../../models/app_request_options.dart';

class ErrorHandlerMiddleware {
  final ServerRequestManager serverRequestManager;

  ErrorHandlerMiddleware(this.serverRequestManager);

  Future<dynamic> sendRequest(AppRequestOptions appRequestOptions) async {
    try {
      final networkChange = await sl<NetWorkChange>().checkNetworkChange();
      if (networkChange) {
        throw const ServerException(
            message: "vpn detected",
            type: ExceptionType.vpn,
            data: null);
      }
      if(appRequestOptions.showLog){
        debugPrint("request for ${appRequestOptions.url} ....");
      }
      Response response =
          await serverRequestManager.sendRequest(appRequestOptions);
      if (response.statusCode == AppUrls.wrongTokenCode &&
          appRequestOptions.url != AppUrls.refreshUrl) {
        throw ServerException(
            message: "wrong token",
            type: ExceptionType.auth,
            data: response.data);
      } else {
        if (appRequestOptions.showLog && AppConstants.developMode) {
          if (response.requestOptions.data is FormData) {
            debugPrint(
                (response.requestOptions.data as FormData).fields.toString());
          } else {
            debugPrint(response.requestOptions.data.toString());
          }
          debugPrint(appRequestOptions.type.toString());
          log("response for ${appRequestOptions.url} : $response");
        }
        if (appRequestOptions.checkResponse) {
          if ((response.statusCode ?? 600) < 300) {
            return response.data;
          } else if ((response.statusCode ?? 600) >= 500) {
            throw ServerException(
                data: response.data,
                type: ExceptionType.unExpected,
                message: "Something Went Wrong");
          } else {
            throw ServerException(
                message: response.data["message"] ?? "Un expected error",
                data: response.data);
          }
        } else {
          return response.data;
        }
      }
    } on ServerException catch (e) {
      debugPrint(e.toString());
      rethrow;
    } on DioError catch (e) {
      debugPrint(e.toString());
      if (e.message.contains('CERTIFICATE_VERIFY_FAILED')) {
        throw ServerException(message: e.message, type: ExceptionType.ssl);
      }
    } catch (e) {
      debugPrint(e.toString());
      if(e is TypeError){
        debugPrint(e.stackTrace.toString());
      }
      throw ServerException(
          message: e.toString(), type: ExceptionType.unExpected,);
    }
  }
}
