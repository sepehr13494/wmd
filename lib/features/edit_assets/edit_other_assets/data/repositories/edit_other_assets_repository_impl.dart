import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:dartz/dartz.dart';

import '../models/put_other_assets_params.dart';

    import '../models/delete_other_assets_params.dart';

    
import '../../domain/repositories/edit_other_assets_repository.dart';
import '../data_sources/edit_other_assets_remote_datasource.dart';

class EditOtherAssetsRepositoryImpl implements EditOtherAssetsRepository {
  final EditOtherAssetsRemoteDataSource remoteDataSource;

  EditOtherAssetsRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, AppSuccess>> putOtherAssets(PutOtherAssetsParams params) async {
    try {
      final result = await remoteDataSource.putOtherAssets(params);
      return const Right(AppSuccess(message: "successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
      @override
  Future<Either<Failure, AppSuccess>> deleteOtherAssets(DeleteOtherAssetsParams params) async {
    try {
      final result = await remoteDataSource.deleteOtherAssets(params);
      return const Right(AppSuccess(message: "successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
    
}

