import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/get_liablility_overview_params.dart';
import '../entities/get_liablility_overview_entity.dart';


abstract class LiablilityOverviewRepository {
  Future<Either<Failure, List<GetLiablilityOverviewEntity>>> getLiablilityOverview(GetLiablilityOverviewParams params);

}
    