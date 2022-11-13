part of 'main_dashboard_cubit.dart';

abstract class MainDashboardState {}

class MainDashboardNetWorthLoaded extends Equatable with MainDashboardState {
  final NetWorthResponseObj? netWorthObj;

  MainDashboardNetWorthLoaded({required this.netWorthObj});

  @override
  List<Object> get props => [];
}
