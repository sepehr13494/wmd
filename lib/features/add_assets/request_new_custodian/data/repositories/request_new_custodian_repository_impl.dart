import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:dartz/dartz.dart';

import '../models/request_new_custodian_params.dart';

    
import '../../domain/repositories/request_new_custodian_repository.dart';
import '../data_sources/request_new_custodian_remote_datasource.dart';

class RequestNewCustodianRepositoryImpl implements RequestNewCustodianRepository {
  final RequestNewCustodianRemoteDataSource remoteDataSource;

  RequestNewCustodianRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, AppSuccess>> requestNewCustodian(RequestNewCustodianParams params) async {
    try {
      final result = await remoteDataSource.requestNewCustodian(params);
      return const Right(AppSuccess(message: "Successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
    
}

