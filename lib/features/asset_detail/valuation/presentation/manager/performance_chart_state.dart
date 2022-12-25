part of 'performance_chart_cubit.dart';

abstract class PerformanceChartState {}

class PerformanceLoaded extends Equatable with PerformanceChartState {
  final GetValuationPerformanceResponse performanceEntity;

  PerformanceLoaded({required this.performanceEntity});

  @override
  List<Object?> get props => [performanceEntity];
}
