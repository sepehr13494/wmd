import 'package:dio/dio.dart';
import '../../util/local_storage.dart';

class NetworkHelper {
  final LocalStorage localStorage;
  NetworkHelper(this.localStorage);

  Dio getDio() {
    Map<String, String> headers = {
      'content-type': 'application/json',
      'accept': "application/json",
    };
    var options = BaseOptions(
      followRedirects: false,
      validateStatus: (status) {
        return true;
      },
      headers: headers,
      connectTimeout: 15000,
    );
    Dio dio = Dio(options);
    // For refreshing token every request
    dio.interceptors.clear();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          final String token = localStorage.getToken();
          request.headers['Authorization'] = token;
          return handler.next(request);
        },
      ),
    );
    return dio;
  }
}
