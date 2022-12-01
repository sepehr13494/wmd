class GetDetailParams {
  final String type;
  final String assetId;
  GetDetailParams({required this.type, required this.assetId});

  factory GetDetailParams.fromJson(Map<String, dynamic> json) {
    return GetDetailParams(assetId: json['assetId'], type: json['type']);
  }

  Map<String, dynamic> toJson() => {
        'assetId': assetId,
        'type': type,
      };
}
