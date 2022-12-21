import 'package:equatable/equatable.dart';

class GetValuationPerformanceParams extends Equatable {
  final String id;
  final int days;
  const GetValuationPerformanceParams({
    required this.id,
    required this.days,
  });

  factory GetValuationPerformanceParams.fromJson(Map<String, dynamic> json) =>
      GetValuationPerformanceParams(
        days: json['days'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {};

  @override
  List<Object?> get props => [];

  static const tParams = GetValuationPerformanceParams(days: 7, id: '123');
}
