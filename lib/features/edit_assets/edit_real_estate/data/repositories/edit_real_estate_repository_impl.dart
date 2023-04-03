import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:dartz/dartz.dart';

import '../models/put_real_estate_params.dart';

    import '../models/delete_real_estate_params.dart';

    
import '../../domain/repositories/edit_real_estate_repository.dart';
import '../data_sources/edit_real_estate_remote_datasource.dart';

class EditRealEstateRepositoryImpl implements EditRealEstateRepository {
  final EditRealEstateRemoteDataSource remoteDataSource;

  EditRealEstateRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, AppSuccess>> putRealEstate(PutRealEstateParams params) async {
    try {
      final result = await remoteDataSource.putRealEstate(params);
      return const Right(AppSuccess(message: "successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
      @override
  Future<Either<Failure, AppSuccess>> deleteRealEstate(DeleteRealEstateParams params) async {
    try {
      final result = await remoteDataSource.deleteRealEstate(params);
      return const Right(AppSuccess(message: "successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
    
}

