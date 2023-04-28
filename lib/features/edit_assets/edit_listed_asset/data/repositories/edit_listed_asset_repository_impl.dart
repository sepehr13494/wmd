import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:dartz/dartz.dart';

import '../models/put_listed_asset_params.dart';

    import '../models/delete_listed_asset_params.dart';

    
import '../../domain/repositories/edit_listed_asset_repository.dart';
import '../data_sources/edit_listed_asset_remote_datasource.dart';

class EditListedAssetRepositoryImpl implements EditListedAssetRepository {
  final EditListedAssetRemoteDataSource remoteDataSource;

  EditListedAssetRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, AppSuccess>> putListedAsset(PutListedAssetParams params) async {
    try {
      final result = await remoteDataSource.putListedAsset(params);
      return const Right(AppSuccess(message: "Successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
      @override
  Future<Either<Failure, AppSuccess>> deleteListedAsset(DeleteListedAssetParams params) async {
    try {
      final result = await remoteDataSource.deleteListedAsset(params);
      return const Right(AppSuccess(message: "Successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
    
}

