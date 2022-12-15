import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_valuation_performance_params.dart';
import '../entities/get_valuation_performance_entity.dart';
import '../repositories/valuation_repository.dart';

class GetValuationPerformanceUseCase extends UseCase<List<GetValuationPerformanceEntity>, GetValuationPerformanceParams> {
  final ValuationRepository repository;

  GetValuationPerformanceUseCase(this.repository);
  @override
  Future<Either<Failure, List<GetValuationPerformanceEntity>>> call(GetValuationPerformanceParams params) =>
      repository.getValuationPerformance(params);
}
      

    