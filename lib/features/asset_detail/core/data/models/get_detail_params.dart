import 'package:equatable/equatable.dart';

class GetDetailParams extends Equatable {
  final String type;
  final String assetId;
  const GetDetailParams({required this.type, required this.assetId});

  factory GetDetailParams.fromJson(Map<String, dynamic> json) {
    return GetDetailParams(assetId: json['assetId'], type: json['type']);
  }

  Map<String, dynamic> toJson() => {
        'assetId': assetId,
        'type': type,
      };

  static final tGetDetailsJson = {
    'assetId': 'assetId',
    'type': 'BankAccount',
  };

  @override
  List<Object?> get props => [
        type,
        assetId,
      ];
}
