import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/features/asset_see_more/core/data/models/get_asset_see_more_response.dart';
import '../models/get_asset_see_more_params.dart';
import '../../domain/repositories/asset_see_more_repository.dart';
import '../data_sources/asset_see_more_remote_datasource.dart';

class AssetSeeMoreRepositoryImpl implements AssetSeeMoreRepository {
  final AssetSeeMoreRemoteDataSource remoteDataSource;

  AssetSeeMoreRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, GetSeeMoreResponse>> getAssetSeeMore(
      GetSeeMoreParams params) async {
    try {
      final result = await remoteDataSource.getAssetSeeMore(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }
}
