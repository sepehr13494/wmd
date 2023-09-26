part of 'valuation_cubit.dart';

abstract class ValuationState {}

class GetAllValuationLoaded extends Equatable with ValuationState {
  final List<GetAllValuationEntity> getAllValuationEntities;
  final List<GetAllValuationEntity> getAllTransactionEntities;

  GetAllValuationLoaded({
    required this.getAllValuationEntities,
    required this.getAllTransactionEntities,
  });

  @override
  List<Object?> get props =>
      [getAllValuationEntities, getAllTransactionEntities];
}

class GetAllTransactionLoaded extends Equatable with ValuationState {
  final List<GetAllValuationEntity> getAllTransactionEntities;

  GetAllTransactionLoaded({
    required this.getAllTransactionEntities,
  });

  @override
  List<Object?> get props => [
        getAllTransactionEntities,
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
