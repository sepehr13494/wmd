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
      Response response =
          await serverRequestManager.sendRequest(appRequestOptions);
      if (response.statusCode == AppUrls.wrongTokenCode &&
          appRequestOptions.url != AppUrls.refreshUrl) {
        throw ServerException(
            message: "wrong token",
            type: ServerExceptionType.auth,
            data: response.data);
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
            return response.data as Map<String, dynamic>;
          } else {
            throw ServerException(
                message: response.data["message"] ?? "Un expected error",
                data: response.data);
          }
        } else {
          return response.data as Map<String, dynamic>;
        }
      }
    } on ServerException catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException(
          message: e.toString(), type: ServerExceptionType.unExpected);
    }
  }

  Future<T> sendRequestType<T>(AppRequestOptions appRequestOptions) async {
    try {
      Response response =
          await serverRequestManager.sendRequest(appRequestOptions);
      if (response.statusCode == AppUrls.wrongTokenCode &&
          appRequestOptions.url != AppUrls.refreshUrl) {
        throw ServerException(
            message: "wrong token",
            type: ServerExceptionType.auth,
            data: response.data);
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
            return response.data as T;
          } else {
            throw ServerException(
                message: response.data["message"] ?? "Un expected error",
                data: response.data);
          }
        } else {
          return response.data as T;
        }
      }
    } on ServerException catch (e) {
      debugPrint(e.toString());
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException(
          message: e.toString(), type: ServerExceptionType.unExpected);
    }
  }
}
