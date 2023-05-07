import 'dart:developer';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../util/local_storage.dart';

class NetworkHelper {
  final LocalStorage localStorage;
  NetworkHelper(this.localStorage);

  Dio getDio(ByteData sslCert) {
    Map<String, String> headers = {
      'content-type': 'application/json',
      'accept': "application/json",
      'App-Id': dotenv.env['APP_ID']!,
    };
    var options = BaseOptions(
      followRedirects: false,
      validateStatus: (status) {
        return true;
      },
      headers: headers,
      connectTimeout: 15000,
    );
    options.headers.remove(Headers.contentLengthHeader);
    Dio dio = Dio(options);
    // For refreshing token every request
    dio.interceptors.clear();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          final String token = localStorage.getToken();
          request.headers['Authorization'] = token;
          request.headers['Accept-Language'] =
              localStorage.getLocale().toLanguageTag();
          return handler.next(request);
        },
      ),
    );

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      SecurityContext securityContext = SecurityContext();
      client.badCertificateCallback = (cert, host, port) {
        log('Mert log: $cert');
        log('Mert log: $host');
        log('Mert log: $port');
        return false;
      };
      securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
      // final SecurityContext context = SecurityContext();
      // context.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
      return HttpClient(context: securityContext);
    };
    return dio;
  }
}
