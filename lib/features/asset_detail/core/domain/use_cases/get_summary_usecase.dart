import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/asset_detail/core/domain/repositories/asset_summary_repository.dart';
import '../../data/models/get_summary_params.dart';
import '../entities/asset_summary_entity.dart';

class GetSummaryUseCase extends UseCase<AssetSummaryEntitiy, GetSummaryParams> {
  final AssetSummaryRepository repository;

  GetSummaryUseCase(this.repository);

  @override
  Future<Either<Failure, AssetSummaryEntitiy>> call(GetSummaryParams params) =>
      repository.getSummary(params);
}
