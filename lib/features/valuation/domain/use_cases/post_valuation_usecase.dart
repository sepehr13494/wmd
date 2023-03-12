import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/post_valuation_params.dart';
import '../entities/post_valuation_entity.dart';
import '../repositories/valuation_repository.dart';

class PostValuationUseCase extends UseCase<PostValuationEntity, PostValuationParams> {
  final ValuationRepository repository;

  PostValuationUseCase(this.repository);
  
  @override
  Future<Either<Failure, PostValuationEntity>> call(PostValuationParams params) =>
      repository.postValuation(params);
}
      

    