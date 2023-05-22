import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:dartz/dartz.dart';

import '../models/get_liablility_overview_params.dart';
import '../../domain/entities/get_liablility_overview_entity.dart';

import '../../domain/repositories/liablility_overview_repository.dart';
import '../data_sources/liablility_overview_remote_datasource.dart';

class LiabilityOverviewRepositoryImpl implements LiabilityOverviewRepository {
  final LiabilityOverviewRemoteDataSource remoteDataSource;

  LiabilityOverviewRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<GetLiablilityOverviewEntity>>>
      getLiablilityOverview(GetLiabilityOverviewParams params) async {
    try {
      final result = await remoteDataSource.getLiablilityOverview(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }
}
