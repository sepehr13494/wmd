import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:dartz/dartz.dart';

import '../models/reset_params.dart';

    
import '../../domain/repositories/profile_reset_password_repository.dart';
import '../data_sources/profile_reset_password_remote_datasource.dart';

class ProfileResetPasswordRepositoryImpl implements ProfileResetPasswordRepository {
  final ProfileResetPasswordRemoteDataSource remoteDataSource;

  ProfileResetPasswordRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, AppSuccess>> reset(ResetParams params) async {
    try {
      final result = await remoteDataSource.reset(params);
      return const Right(AppSuccess());
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
    
}

