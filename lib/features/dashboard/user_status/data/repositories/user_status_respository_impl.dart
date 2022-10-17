import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/features/dashboard/user_status/data/data_sources/user_status_remote_data_source.dart';
import 'package:wmd/features/dashboard/user_status/data/models/user_status.dart';
import 'package:wmd/features/dashboard/user_status/domain/repositories/user_status_repository.dart';

class UserStatusRepositoryImpl implements UserStatusRepository {
  final UserStatusRemoteDataSource dashboardRemoteDataSource;

  UserStatusRepositoryImpl(this.dashboardRemoteDataSource);
  @override
  Future<Either<Failure, UserStatus>> getUserStatus(NoParams noParams) async {
    try {
      final result = await dashboardRemoteDataSource.getUserStatus(noParams);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message));
    }
  }

  @override
  Future<Either<Failure, UserStatus>> putUserStatus(UserStatus noParams) {
    // TODO: implement putUserStatus
    throw UnimplementedError();
  }
}
