import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/asset_detail/valuation/domain/entities/get_all_valuation_entity.dart';
import 'package:wmd/features/valuation/data/models/get_valuation_params.dart';

import '../repositories/valuation_repository.dart';

class AssetGetValuationUseCase
    extends UseCase<GetAllValuationEntity, GetValuationParams> {
  final AssetValuationRepository repository;

  AssetGetValuationUseCase(this.repository);

  @override
  Future<Either<Failure, GetAllValuationEntity>> call(
          GetValuationParams params) =>
      repository.getValuationById(params);
}
