import '../../domain/entities/get_benchmark_entity.dart';

class GetBenchmarkResponse extends GetBenchmarkEntity {
  const GetBenchmarkResponse({
    required String index,
    required double performance,
    required double performancePa,
    required double riskPa,
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
        index: json["index"]??"",
        performance: double.tryParse((json["performance"]??"0").toString())??0,
        performancePa: double.tryParse((json["performancePa"]??"0").toString())??0,
        riskPa: double.tryParse((json["riskPa"]??"0").toString())??0,
        sharpeRatio: double.tryParse((json["sharpeRatio"]??"0").toString())??0,
      );

  static final tResponse = [GetBenchmarkResponse.fromJson(const {
    "index": "S&P 500",
    "performance": 115.06,
    "performancePA": 100,
    "riskPA": 2000,
    "sharpeRatio": 0.23
  })];
}
