import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/assets_overview_repository.dart';
import '../data_sources/asset_overview_remote_datasource.dart';
import '../models/assets_overview_params.dart';
import '../models/assets_overview_response.dart';

class AssetsOverviewRepositoryImpl implements AssetsOverviewRepository {
  final AssetsOverviewRemoteDataSource remoteDataSource;

  AssetsOverviewRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<AssetsOverviewResponse>>> getAssetsOverview(AssetsOverviewParams params) async {
    try {
      final result = await remoteDataSource.getAssetsOverview(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    }
  }
}
