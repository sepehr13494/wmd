import '../../domain/entities/get_benchmark_entity.dart';

class GetBenchmarkResponse extends GetBenchmarkEntity {
  GetBenchmarkResponse({
    required String index,
    required double performance,
    required int performancePa,
    required int riskPa,
    required double sharpeRatio,
  }) : super(
          index: index,
          performance: performance,
          performancePa: performancePa,
          riskPa: riskPa,
          sharpeRatio: sharpeRatio,
        );

  factory GetBenchmarkResponse.fromJson(Map<String, dynamic> json) =>
      GetBenchmarkResponse(
        index: json["index"],
        performance: json["performance"].toDouble(),
        performancePa: json["performancePA"],
        riskPa: json["riskPA"],
        sharpeRatio: json["sharpeRatio"].toDouble(),
      );

  static final tResponse = [GetBenchmarkResponse.fromJson(const {
    "index": "S&P 500",
    "performance": 115.06,
    "performancePA": 100,
    "riskPA": 2000,
    "sharpeRatio": 0.23
  })];
}
