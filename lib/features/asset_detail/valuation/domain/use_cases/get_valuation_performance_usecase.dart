import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/asset_detail/valuation/data/models/get_valuation_performance_response.dart';

import '../../data/models/get_valuation_performance_params.dart';
import '../entities/valuation_history_entity.dart';
import '../repositories/valuation_repository.dart';

class GetValuationPerformanceUseCase extends UseCase<
    GetValuationPerformanceResponse, GetValuationPerformanceParams> {
  final ValuationRepository repository;

  GetValuationPerformanceUseCase(this.repository);
  @override
  Future<Either<Failure, GetValuationPerformanceResponse>> call(
          GetValuationPerformanceParams params) =>
      repository.getValuationPerformance(params);
}
