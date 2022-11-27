import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import '../../data/models/assets_overview_params.dart';
import '../entities/assets_overview_entity.dart';
import '../repositories/assets_overview_repository.dart';

class GetAssetsOverviewUseCase extends UseCase<List<AssetsOverviewEntity>, AssetsOverviewParams> {
  final AssetsOverviewRepository repository;

  GetAssetsOverviewUseCase(this.repository);
  @override
  Future<Either<Failure, List<AssetsOverviewEntity>>> call(AssetsOverviewParams params) =>
      repository.getAssetsOverview(params);
}
