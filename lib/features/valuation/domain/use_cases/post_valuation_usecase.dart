import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/post_valuation_params.dart';
import '../entities/post_valuation_entity.dart';
import '../repositories/valuation_repository.dart';

class AssetPostValuationUseCase
    extends UseCase<AppSuccess, PostValuationParams> {
  final AssetValuationRepository repository;

  AssetPostValuationUseCase(this.repository);

  @override
  Future<Either<Failure, AppSuccess>> call(PostValuationParams params) =>
      repository.postValuation(params);
}
