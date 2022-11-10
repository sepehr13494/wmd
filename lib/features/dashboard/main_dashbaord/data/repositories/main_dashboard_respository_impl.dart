import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/data_sources/main_dashboard_remote_data_source.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/models/main_dashboard_model.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/models/net_worth_params.dart';
import 'package:wmd/features/dashboard/main_dashbaord/domain/repositories/main_dashboard_repository.dart';
import 'package:wmd/features/dashboard/user_status/data/models/user_status.dart';

class MainDashboardRepositoryImpl implements MainDashboardRepository {
  final MainDashboardRemoteDataSource dashboardRemoteDataSource;

  MainDashboardRepositoryImpl(this.dashboardRemoteDataSource);

  @override
  Future<Either<Failure, NetWorthObj>> userNetWorth(NetWorthParams params) async {
    try {
      final result = await dashboardRemoteDataSource.userNetWorth(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message));
    }
  }
}
