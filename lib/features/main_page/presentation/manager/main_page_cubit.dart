import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';

class MainPageCubit extends Cubit<int> {

  MainPageCubit() : super(0);

  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    emit(selectedIndex);
  }

  void initMainScreen(BuildContext context){
    context.read<UserStatusCubit>().getUserStatus();
    context.read<MainDashboardCubit>().getNetWorth();
  }

}
