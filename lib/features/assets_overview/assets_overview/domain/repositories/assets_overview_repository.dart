import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import '../../data/models/assets_overview_params.dart';
import '../entities/assets_overview_entity.dart';

abstract class AssetsOverviewRepository {
  Future<Either<Failure, List<AssetsOverviewEntity>>> getAssetsOverview(AssetsOverviewParams params);
}
