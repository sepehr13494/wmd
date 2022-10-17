import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/features/dashboard/data/data_sources/dashboard_remote_data_source.dart';
import 'package:wmd/features/dashboard/data/models/user_status.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource dashboardRemoteDataSource;

  DashboardRepositoryImpl(this.dashboardRemoteDataSource);
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
