import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../util/constants.dart';
import 'urls.dart';
import '../../models/app_request_options.dart';

enum RequestTypes { post, get, del, put, patch, delete }

class ServerRequestManager {
  final Dio dio;
  ServerRequestManager(this.dio);

  Future<Response> sendRequest(AppRequestOptions appRequestOptions) async {
    String baseUrl = appRequestOptions.fullUrl ? "" : AppUrls.baseUrl;
    Response response;
    dynamic clearBody;
    if (appRequestOptions.body != null &&
        appRequestOptions.body is Map<String, dynamic>) {
      clearBody = appRequestOptions.body;
      clearBody!.removeWhere((key, value) => value == null);
    } else if (appRequestOptions.body is List<dynamic>) {
      clearBody = jsonEncode(appRequestOptions.body);
    }

    dynamic options = appRequestOptions.additionalHeaders == null
        ? null
        : Options(headers: appRequestOptions.additionalHeaders);

    switch (appRequestOptions.type) {
      case RequestTypes.post:
        response = await dio.post(
          baseUrl + appRequestOptions.url,
          data: clearBody,
          onSendProgress: appRequestOptions.onSendProgress == null
              ? null
              : (int sent, int total) {
                  appRequestOptions.onSendProgress!(sent, total);
                },
          options: options,
        );
        break;
      case RequestTypes.get:
        response = await dio.get(
          baseUrl + appRequestOptions.url,
          queryParameters: clearBody,
          options: options,
        );
        break;
      case RequestTypes.del:
        response = await dio.delete(
          baseUrl + appRequestOptions.url,
          data: clearBody,
          options: options,
        );
        break;
      case RequestTypes.delete:
        response = await dio.delete(
          baseUrl + appRequestOptions.url,
          data: clearBody,
          options: options,
        );
        break;
      case RequestTypes.put:
        response = await dio.put(
          baseUrl + appRequestOptions.url,
          data: clearBody,
          options: options,
        );
        break;
      case RequestTypes.patch:
        response = await dio.patch(
          baseUrl + appRequestOptions.url,
          data: clearBody,
          options: options,
        );
        break;
    }
    if (appRequestOptions.showLog && AppConstants.developMode) {
      debugPrint(response.requestOptions.uri.toString());
      debugPrint(response.requestOptions.headers.toString());
      debugPrint(response.statusCode.toString());
    }

    return response;
  }
}
