import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/models/net_worth_response_obj.dart';
import '../../data/models/net_worth_params.dart';

abstract class MainDashboardRepository {
  Future<Either<Failure, NetWorthResponseObj>> userNetWorth(NetWorthParams params);
}
