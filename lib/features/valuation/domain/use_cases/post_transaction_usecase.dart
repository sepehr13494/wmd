import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/valuation/domain/repositories/transaction_repository.dart';

import '../../data/models/post_valuation_params.dart';

class AssetPostTransactionUseCase
    extends UseCase<AppSuccess, PostValuationParams> {
  final AssetTransactionRepository repository;

  AssetPostTransactionUseCase(this.repository);

  @override
  Future<Either<Failure, AppSuccess>> call(PostValuationParams params) =>
      repository.postValuation(params);
}
