import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/features/dashboard/user_status/data/data_sources/user_status_remote_data_source.dart';
import 'package:wmd/features/dashboard/user_status/data/models/user_status.dart';
import 'package:wmd/features/dashboard/user_status/domain/repositories/user_status_repository.dart';

class UserStatusRepositoryImpl implements UserStatusRepository {
  final UserStatusRemoteDataSource dashboardRemoteDataSource;
  final LocalStorage localStorage;

  UserStatusRepositoryImpl(this.dashboardRemoteDataSource, this.localStorage);
  @override
  Future<Either<Failure, UserStatus>> getUserStatus(NoParams noParams) async {
    try {
      final result = await dashboardRemoteDataSource.getUserStatus(noParams);
      localStorage.setOwnerId(result.userId);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message,type: error.type));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }

  @override
  Future<Either<Failure, UserStatus>> putUserStatus(
      UserStatus userStatusRequest) async {
    try {
      final result = await dashboardRemoteDataSource.putUserStatus(userStatusRequest);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
}
