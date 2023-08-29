import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/valuation/data/models/get_valuation_params.dart';
import 'package:wmd/features/valuation/domain/repositories/transaction_repository.dart';

class AssetDeleteTransactionUseCase
    extends UseCase<AppSuccess, GetValuationParams> {
  final AssetTransactionRepository repository;

  AssetDeleteTransactionUseCase(this.repository);

  @override
  Future<Either<Failure, AppSuccess>> call(GetValuationParams params) =>
      repository.deleteValuation(params);
}
