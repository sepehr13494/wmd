import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:dartz/dartz.dart';

import '../models/get_client_index_params.dart';
import '../../domain/entities/get_client_index_entity.dart';
    
import '../../domain/repositories/client_index_repository.dart';
import '../data_sources/client_index_remote_datasource.dart';

class ClientIndexRepositoryImpl implements ClientIndexRepository {
  final ClientIndexRemoteDataSource remoteDataSource;

  ClientIndexRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, GetClientIndexEntity>> getClientIndex(GetClientIndexParams params) async {
    try {
      final result = await remoteDataSource.getClientIndex(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }

}

