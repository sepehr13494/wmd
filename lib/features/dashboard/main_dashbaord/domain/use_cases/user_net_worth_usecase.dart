import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/models/net_worth_response_obj.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/models/net_worth_params.dart';
import 'package:wmd/features/dashboard/main_dashbaord/domain/repositories/main_dashboard_repository.dart';

class UserNetWorthUseCase extends UseCase<NetWorthResponseObj, DateTimeRange?> {
  final MainDashboardRepository dashboardRepository;

  UserNetWorthUseCase(this.dashboardRepository);
  @override
  Future<Either<Failure, NetWorthResponseObj>> call(DateTimeRange? params) {
    late NetWorthParams finalParams;
    if(params != null){
      finalParams = NetWorthParams(from: params.start, to: params.end);
    }else{
      finalParams = NetWorthParams();
    }
    return dashboardRepository.userNetWorth(finalParams);
  }
}