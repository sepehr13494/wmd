import 'package:equatable/equatable.dart';

import '../data/network/server_request_manager.dart';

class AppRequestOptions extends Equatable {
  final RequestTypes type;
  final String url;
  final dynamic body;
  final bool checkResponse;
  final bool showLog;
  final void Function(int, int)? onSendProgress;
  final bool fullUrl;
  final Map<String, String>? additionalHeaders;

  AppRequestOptions(
    this.type,
    this.url,
    this.body, {
    this.checkResponse = true,
    this.showLog = true,
    this.onSendProgress,
    this.fullUrl = false,
    this.additionalHeaders,
  });

  @override
  List<Object?> get props =>
      [type, url, body, checkResponse, onSendProgress, fullUrl];
}
