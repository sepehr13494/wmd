import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'urls.dart';
import '../../models/app_request_options.dart';

enum RequestTypes { post, get, del, put, patch }

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
    }
    switch (appRequestOptions.type) {
      case RequestTypes.post:
        response = await dio.post(baseUrl + appRequestOptions.url,
            data: clearBody,
            onSendProgress: appRequestOptions.onSendProgress == null
                ? null
                : (int sent, int total) {
                    appRequestOptions.onSendProgress!(sent, total);
                  });
        break;
      case RequestTypes.get:
        response = await dio.get(
          baseUrl + appRequestOptions.url,
          queryParameters: clearBody,
        );
        break;
      case RequestTypes.del:
        response =
            await dio.delete(baseUrl + appRequestOptions.url, data: clearBody);
        break;
      case RequestTypes.put:
        response = await dio.put(
          baseUrl + appRequestOptions.url,
          data: clearBody,
        );
        break;
      case RequestTypes.patch:
        response = await dio.patch(
          baseUrl + appRequestOptions.url,
          data: clearBody,
        );
        break;
    }
    if (appRequestOptions.showLog) {
      debugPrint(response.requestOptions.uri.toString());
      debugPrint(response.requestOptions.headers.toString());
      debugPrint(response.statusCode.toString());
      debugPrint(response.data.toString());
    }

    return response;
  }
}
