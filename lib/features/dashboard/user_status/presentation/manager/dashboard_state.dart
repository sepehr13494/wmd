part of 'dashboard_cubit.dart';

abstract class DashboardState {}

class DashboardUserStateLoaded extends DashboardState {
  final UserStatus userStatus;

  DashboardUserStateLoaded({required this.userStatus});
}
