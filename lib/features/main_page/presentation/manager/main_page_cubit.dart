import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:wmd/features/dashboard/user_status/domain/use_cases/get_user_status_usecase.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/injection_container.dart';

class MainPageCubit extends Cubit<int> {
  MainPageCubit() : super(0);


  void onItemTapped(int index) {
    emit(index);
  }

}
