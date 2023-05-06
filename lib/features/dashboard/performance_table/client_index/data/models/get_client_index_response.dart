import 'package:wmd/features/dashboard/performance_table/data/models/get_benchmark_response.dart';

import '../../domain/entities/get_client_index_entity.dart';

class GetClientIndexResponse  extends GetClientIndexEntity{
  const GetClientIndexResponse({required super.index, required super.performance, required super.performancePa, required super.riskPa, required super.sharpeRatio});

  static final tResponse = GetClientIndexResponse.fromJson(const {
      "index": "S&P 500",
      "performance": 115.06,
      "performancePA": 100,
      "riskPA": 2000,
      "sharpeRatio": 0.23
  });

  factory GetClientIndexResponse.fromJson(Map<String, dynamic> json) =>
      GetClientIndexResponse(
        index: json["index"]??"",
        performance: double.tryParse((json["performance"]??"0").toString())??0,
        performancePa: double.tryParse((json["performancePA"]??"0").toString())??0,
        riskPa: double.tryParse((json["riskPA"]??"0").toString())??0,
        sharpeRatio: double.tryParse((json["sharpeRatio"]??"0").toString())??0,
      );
}
