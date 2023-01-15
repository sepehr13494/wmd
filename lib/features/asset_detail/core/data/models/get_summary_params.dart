import 'package:equatable/equatable.dart';

class GetSummaryParams extends Equatable {
  final String assetId;
  final int days;
  const GetSummaryParams({required this.days, required this.assetId});

  factory GetSummaryParams.fromJson(Map<String, dynamic> json) {
    return GetSummaryParams(
      assetId: json['assetId'],
      days: json['days'],
    );
  }

  Map<String, dynamic> toJson() => {
        'assetId': assetId,
        'days': days,
      };

  static final tGetDetailsJson = {
    'assetId': 'assetId',
    'days': 7,
  };

  @override
  List<Object?> get props => [
        assetId,
        days,
      ];
}
