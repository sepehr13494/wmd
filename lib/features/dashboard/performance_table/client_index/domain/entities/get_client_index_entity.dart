import 'package:wmd/features/dashboard/performance_table/data/models/get_benchmark_response.dart';
import 'package:wmd/features/dashboard/performance_table/domain/entities/get_benchmark_entity.dart';

class GetClientIndexEntity extends GetBenchmarkEntity {
  const GetClientIndexEntity(
      {required super.index,
      required super.performance,
      required super.performancePa,
      required super.riskPa,
      required super.sharpeRatio});

  static GetBenchmarkResponse benchMarkFromClient(
      {required GetClientIndexEntity getClientIndexEntity}) {
    return GetBenchmarkResponse(
      index: getClientIndexEntity.index,
      performance: getClientIndexEntity.performance,
      performancePa: getClientIndexEntity.performancePa,
      riskPa: getClientIndexEntity.riskPa,
      sharpeRatio: getClientIndexEntity.sharpeRatio,
    );
  }
}
