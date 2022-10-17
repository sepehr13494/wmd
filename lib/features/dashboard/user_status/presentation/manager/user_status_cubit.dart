import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/dashboard/user_status/data/models/user_status.dart';

part 'user_status_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(LoadingState());
}
