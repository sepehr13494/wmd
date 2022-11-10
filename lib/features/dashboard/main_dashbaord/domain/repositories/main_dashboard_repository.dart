import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/models/main_dashboard_model.dart';
import '../../data/models/net_worth_params.dart';

abstract class MainDashboardRepository {
  Future<Either<Failure, NetWorthObj>> userNetWorth(NetWorthParams params);
}
