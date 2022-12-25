part of 'valuation_cubit.dart';

abstract class ValuationState {}

class GetAllValuationLoaded extends Equatable with ValuationState {
  final List<GetAllValuationEntity> getAllValuationEntities;

  GetAllValuationLoaded({
    required this.getAllValuationEntities,
  });

  @override
  List<Object?> get props => [
        getAllValuationEntities,
      ];
}

class GetValuationPerformanceLoaded extends Equatable with ValuationState {
  final List<ValuationHistoryEntity> getValuationPerformanceEntities;

  GetValuationPerformanceLoaded({
    required this.getValuationPerformanceEntities,
  });

  @override
  List<Object?> get props => [
        getValuationPerformanceEntities,
      ];
}
