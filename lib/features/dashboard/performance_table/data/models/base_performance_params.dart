import 'package:equatable/equatable.dart';

class BasePerformanceParams extends Equatable{
  const BasePerformanceParams({
    required this.period,
  });

  final String period;

  factory BasePerformanceParams.fromJson(Map<String, dynamic> json) => BasePerformanceParams(
    period: json["period"],
  );

  Map<String, dynamic> toJson() => {
    "period": period,
  };

  static const tParams = BasePerformanceParams(period: "Last7Days");

  @override
  List<Object?> get props => [period];
}