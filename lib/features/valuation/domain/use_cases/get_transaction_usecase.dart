import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/valuation/data/models/get_valuation_params.dart';
import 'package:wmd/features/valuation/domain/entities/get_valuation_entity.dart';
import 'package:wmd/features/valuation/domain/repositories/transaction_repository.dart';

class AssetGetTransactionUseCase
    extends UseCase<GetValuationEntity, GetValuationParams> {
  final AssetTransactionRepository repository;

  AssetGetTransactionUseCase(this.repository);

  @override
  Future<Either<Failure, GetValuationEntity>> call(GetValuationParams params) =>
      repository.getValuationById(params);
}
