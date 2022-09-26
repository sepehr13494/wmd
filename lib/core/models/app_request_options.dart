import '../data/network/server_request_manager.dart';

class AppRequestOptions {
  final RequestTypes type;
  final String url;
  final dynamic body;
  final bool checkResponse;
  final bool showLog;
  final void Function(int, int)? onSendProgress;
  final bool fullUrl;

  AppRequestOptions(
    this.type,
    this.url,
    this.body, {
    this.checkResponse = true,
    this.showLog = true,
    this.onSendProgress,
    this.fullUrl = false,
  });
}
