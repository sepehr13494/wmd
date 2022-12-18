import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/features/assets_overview/assets_overview/domain/entities/assets_overview_entity.dart';

import '../../domain/repositories/assets_overview_repository.dart';
import '../data_sources/asset_overview_remote_datasource.dart';
import '../models/assets_overview_params.dart';

class AssetsOverviewRepositoryImpl implements AssetsOverviewRepository {
  final AssetsOverviewRemoteDataSource remoteDataSource;

  AssetsOverviewRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<AssetsOverviewEntity>>> getAssetsOverview(AssetsOverviewParams params) async {
    try {
      final result = await remoteDataSource.getAssetsOverview(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
}
