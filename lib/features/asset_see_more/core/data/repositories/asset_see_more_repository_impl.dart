import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:dartz/dartz.dart';

import '../models/get_asset_see_more_params.dart';

    
import '../../domain/repositories/asset_see_more_repository.dart';
import '../data_sources/asset_see_more_remote_datasource.dart';

class AssetSeeMoreRepositoryImpl implements AssetSeeMoreRepository {
  final AssetSeeMoreRemoteDataSource remoteDataSource;

  AssetSeeMoreRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, AppSuccess>> getAssetSeeMore(GetSeeMoreParams params) async {
    try {
      final result = await remoteDataSource.getAssetSeeMore(params);
      return const Right(AppSuccess(message: "successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
    
}

