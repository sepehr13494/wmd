import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:dartz/dartz.dart';

import '../models/perform_logout_params.dart';

    
import '../../domain/repositories/logout_repository.dart';
import '../data_sources/logout_remote_datasource.dart';

class LogoutRepositoryImpl implements LogoutRepository {
  final LogoutRemoteDataSource remoteDataSource;

  LogoutRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, AppSuccess>> performLogout(PerformLogoutParams params) async {
    try {
      final result = await remoteDataSource.performLogout(params);
      return const Right(AppSuccess(message: "Successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
    
}

