import 'package:equatable/equatable.dart';

class LinkTokenResponse extends Equatable {
  final String expiration;
  final String linkToken;
  final String requestId;

  const LinkTokenResponse({
    required this.expiration,
    required this.linkToken,
    required this.requestId,
  });
  factory LinkTokenResponse.fromJson(Map<String, dynamic> json) {
    final expiration = json['expiration'].toString();
    final linkToken = json['linkToken'].toString();
    final requestId = json['requestId'].toString();
    return LinkTokenResponse(
        expiration: expiration, linkToken: linkToken, requestId: requestId);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['expiration'] = expiration;
    data['linkToken'] = linkToken;
    data['requestId'] = requestId;
    return data;
  }

  static final tLinkTokenResponse = {
    "expiration": "2022-11-23T13:20:20Z",
    "linkToken": "link-sandbox-5180c00b-478d-430d-a7f0-b11835e099e5",
    "requestId": "qsNAI33QvnsUqRF"
  };

  @override
  List<Object?> get props => [expiration, linkToken, requestId];
}
