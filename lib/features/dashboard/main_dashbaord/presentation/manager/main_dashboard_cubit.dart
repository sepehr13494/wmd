import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/models/net_worth_response_obj.dart';
import 'package:wmd/features/dashboard/main_dashbaord/domain/use_cases/user_net_worth_usecase.dart';

part 'main_dashboard_state.dart';

class MainDashboardCubit extends Cubit<MainDashboardState> {
  final UserNetWorthUseCase userNetWorthUseCase;

  MainDashboardCubit(this.userNetWorthUseCase) : super(LoadingState());

  getNetWorth({DateTimeRange? dateTimeRange}) async {
    emit(LoadingState());
    final result = await userNetWorthUseCase(dateTimeRange);
    result.fold(
        (failure) => emit(ErrorState(failure: failure)), (userNetWorth) {
      emit(MainDashboardNetWorthLoaded(netWorthObj: userNetWorth));
    });
  }
}
