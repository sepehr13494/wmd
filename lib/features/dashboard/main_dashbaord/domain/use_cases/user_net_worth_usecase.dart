import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/models/main_dashboard_model.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/models/net_worth_params.dart';
import 'package:wmd/features/dashboard/main_dashbaord/domain/repositories/main_dashboard_repository.dart';

class UserNetWorthUseCase extends UseCase<NetWorthObj, NetWorthParams> {
  final MainDashboardRepository dashboardRepository;

  UserNetWorthUseCase(this.dashboardRepository);
  @override
  Future<Either<Failure, NetWorthObj>> call(NetWorthParams params) =>
      dashboardRepository.userNetWorth(params);
}
