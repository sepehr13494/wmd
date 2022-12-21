part of 'performance_chart_cubit.dart';

abstract class PerformanceChartState {}

class PerformanceLoaded extends Equatable with PerformanceChartState {
  final List<GetValuationPerformanceEntity> getValuationPerformanceEntities;

  PerformanceLoaded({
    required this.getValuationPerformanceEntities,
  });

  @override
  List<Object?> get props => [
        getValuationPerformanceEntities,
      ];
}
