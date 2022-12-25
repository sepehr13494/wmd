import 'package:wmd/features/asset_detail/valuation/data/models/valuation_history_response.dart';
import 'package:wmd/features/asset_detail/valuation/domain/entities/get_valuation_performance_entity.dart';

import '../../domain/entities/valuation_history_entity.dart';

class GetValuationPerformanceResponse extends GetValuationPerformanceEntity {
  const GetValuationPerformanceResponse(
      {required super.netChange, required super.valuationHistory});

  factory GetValuationPerformanceResponse.fromJson(Map<String, dynamic> json) =>
      GetValuationPerformanceResponse(
          netChange: double.tryParse(json['value'].toString()) ?? 0,
          valuationHistory: (json['valuationHistory'] as List<dynamic>)
              .map((e) => ValuationHistoryResponse.fromJson(e))
              .toList());

  static final tResponse = [
    GetValuationPerformanceResponse(netChange: 150, valuationHistory: [
      ValuationHistoryEntity(date: DateTime.now(), value: 150)
    ])
  ];
}
