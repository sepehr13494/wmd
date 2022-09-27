import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'server_request_manager.dart';
import 'urls.dart';
import '../../error_and_success/exeptions.dart';
import '../../models/app_request_options.dart';

class ErrorHandlerMiddleware {
  final ServerRequestManager serverRequestManager;

  ErrorHandlerMiddleware(this.serverRequestManager);

  Future<Map<String, dynamic>> sendRequest(
      AppRequestOptions appRequestOptions) async {
    try {
      Response response = await serverRequestManager.sendRequest(appRequestOptions);
      if (response.statusCode == AppUrls.wrongTokenCode &&
          appRequestOptions.url != AppUrls.refreshUrl) {
        throw ServerException(message: "wrong token");
      } else {
        if (appRequestOptions.showLog) {
          if (response.requestOptions.data is FormData) {
            debugPrint(
                (response.requestOptions.data as FormData).fields.toString());
          } else {
            debugPrint(response.requestOptions.data.toString());
          }
          debugPrint(appRequestOptions.type.toString());
          log("response : $response");
        }
        if (appRequestOptions.checkResponse) {
          if ((response.statusCode ?? 600) < 300) {
            return response.data;
          } else {
            throw ServerException(message: response.data["message"]);
          }
        } else {
          return response.data;
        }
      }
    } on ServerException catch (e) {
      debugPrint(e.toString());
      throw ServerException(message: e.message);
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException(message: e.toString());
    }
  }
}
