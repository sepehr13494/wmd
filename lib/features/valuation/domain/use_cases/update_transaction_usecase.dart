import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/valuation/domain/repositories/transaction_repository.dart';

import '../../data/models/update_valuation_params.dart';

class UpdateTransactionUseCase
    extends UseCase<AppSuccess, UpdateValuationParams> {
  final AssetTransactionRepository repository;

  UpdateTransactionUseCase(this.repository);

  @override
  Future<Either<Failure, AppSuccess>> call(UpdateValuationParams params) =>
      repository.updateValuation(params);
}
