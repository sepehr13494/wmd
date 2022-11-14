import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/data_sources/main_dashboard_remote_data_source.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/models/net_worth_response_obj.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/models/net_worth_params.dart';
import 'package:wmd/features/dashboard/main_dashbaord/domain/repositories/main_dashboard_repository.dart';

class MainDashboardRepositoryImpl implements MainDashboardRepository {
  final MainDashboardRemoteDataSource dashboardRemoteDataSource;

  MainDashboardRepositoryImpl(this.dashboardRemoteDataSource);

  @override
  Future<Either<Failure, NetWorthResponseObj>> userNetWorth(NetWorthParams params) async {
    try {
      final result = await dashboardRemoteDataSource.userNetWorth(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    }
  }
}
