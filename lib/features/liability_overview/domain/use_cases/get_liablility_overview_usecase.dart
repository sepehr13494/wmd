import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import '../../data/models/get_liablility_overview_params.dart';
import '../entities/get_liablility_overview_entity.dart';
import '../repositories/liablility_overview_repository.dart';

class GetLiabilityOverviewUseCase extends UseCase<
    List<GetLiablilityOverviewEntity>, GetLiabilityOverviewParams> {
  final LiabilityOverviewRepository repository;

  GetLiabilityOverviewUseCase(this.repository);
  @override
  Future<Either<Failure, List<GetLiablilityOverviewEntity>>> call(
          GetLiabilityOverviewParams params) =>
      repository.getLiablilityOverview(params);
}
