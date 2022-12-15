import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_all_valuation_params.dart';
import '../entities/get_all_valuation_entity.dart';
import '../repositories/valuation_repository.dart';

class GetAllValuationUseCase extends UseCase<List<GetAllValuationEntity>, GetAllValuationParams> {
  final ValuationRepository repository;

  GetAllValuationUseCase(this.repository);
  @override
  Future<Either<Failure, List<GetAllValuationEntity>>> call(GetAllValuationParams params) =>
      repository.getAllValuation(params);
}
      

    