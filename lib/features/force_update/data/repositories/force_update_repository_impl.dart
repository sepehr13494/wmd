import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:dartz/dartz.dart';

import '../models/get_force_update_params.dart';
import '../../domain/entities/get_force_update_entity.dart';
    
import '../../domain/repositories/force_update_repository.dart';
import '../data_sources/force_update_remote_datasource.dart';

class ForceUpdateRepositoryImpl implements ForceUpdateRepository {
  final ForceUpdateRemoteDataSource remoteDataSource;

  ForceUpdateRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, GetForceUpdateEntity>> getForceUpdate(GetForceUpdateParams params) async {
    try {
      final result = await remoteDataSource.getForceUpdate(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
    
}

