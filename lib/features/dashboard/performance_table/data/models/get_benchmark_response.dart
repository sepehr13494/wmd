import '../../domain/entities/get_benchmark_entity.dart';

class GetBenchmarkResponse extends GetBenchmarkEntity {
  const GetBenchmarkResponse({
    required String index,
    double? performance,
    double? performancePa,
    double? riskPa,
    double? sharpeRatio,
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
        performance: json["performance"] == null ? null :  double.tryParse((json["performance"]??"0").toString())??0,
        performancePa: json["performancePa"] == null ? null :  double.tryParse((json["performancePA"]??"0").toString())??0,
        riskPa: json["riskPa"] == null ? null :  double.tryParse((json["riskPA"]??"0").toString())??0,
        sharpeRatio: json["sharpeRatio"] == null ? null :  double.tryParse((json["sharpeRatio"]??"0").toString())??0,
      );

  static final tResponse = [GetBenchmarkResponse.fromJson(const {
    "index": "S&P 500",
    "performance": 115.06,
    "performancePA": 100,
    "riskPA": 2000,
    "sharpeRatio": 0.23
  })];
}
