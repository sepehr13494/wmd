part of 'main_dashboard_cubit.dart';

abstract class MainDashboardState {}

class MainDashboardNetWorthLoaded extends Equatable with MainDashboardState {
  final NetWorthObj netWorthObj;

  MainDashboardNetWorthLoaded({required this.netWorthObj});

  @override
  List<Object> get props => [];
}
