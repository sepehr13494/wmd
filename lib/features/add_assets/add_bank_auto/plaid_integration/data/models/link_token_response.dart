class LinkTokenResponse {
  String expiration;
  String linkToken;
  String requestId;

  LinkTokenResponse({
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
}
