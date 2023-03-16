import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_asset_class_params.dart';
import '../entities/get_asset_class_entity.dart';
import '../../data/models/get_benchmark_params.dart';
import '../entities/get_benchmark_entity.dart';
import '../../data/models/get_custodian_performance_params.dart';
import '../entities/get_custodian_performance_entity.dart';


abstract class PerformanceTableRepository {
  Future<Either<Failure, List<GetAssetClassEntity>>> getAssetClass(GetAssetClassParams params);
  Future<Either<Failure, List<GetBenchmarkEntity>>> getBenchmark(GetBenchmarkParams params);
  Future<Either<Failure, List<GetCustodianPerformanceEntity>>> getCustodianPerformance(GetCustodianPerformanceParams params);

}
    