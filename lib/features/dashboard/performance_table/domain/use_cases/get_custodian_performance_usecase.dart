import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_custodian_performance_params.dart';
import '../entities/get_custodian_performance_entity.dart';
import '../repositories/performance_table_repository.dart';

class GetCustodianPerformanceUseCase extends UseCase<List<GetCustodianPerformanceEntity>, GetCustodianPerformanceParams> {
  final PerformanceTableRepository repository;

  GetCustodianPerformanceUseCase(this.repository);
  @override
  Future<Either<Failure, List<GetCustodianPerformanceEntity>>> call(GetCustodianPerformanceParams params) =>
      repository.getCustodianPerformance(params);
}
      

    