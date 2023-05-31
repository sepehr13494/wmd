import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/update_valuation_params.dart';
import '../entities/update_valuation_entity.dart';
import '../repositories/valuation_repository.dart';

class UpdateValuationUseCase
    extends UseCase<AppSuccess, UpdateValuationParams> {
  final AssetValuationRepository repository;

  UpdateValuationUseCase(this.repository);

  @override
  Future<Either<Failure, AppSuccess>> call(UpdateValuationParams params) =>
      repository.updateValuation(params);
}
