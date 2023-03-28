import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_benchmark_params.dart';
import '../entities/get_benchmark_entity.dart';
import '../repositories/performance_table_repository.dart';

class GetBenchmarkUseCase extends UseCase<List<GetBenchmarkEntity>, GetBenchmarkParams> {
  final PerformanceTableRepository repository;

  GetBenchmarkUseCase(this.repository);
  @override
  Future<Either<Failure, List<GetBenchmarkEntity>>> call(GetBenchmarkParams params) =>
      repository.getBenchmark(params);
}
      

    