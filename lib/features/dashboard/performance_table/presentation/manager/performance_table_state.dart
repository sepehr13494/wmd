part of 'performance_table_cubit.dart';

abstract class PerformanceTableState {}

class GetAssetClassLoaded extends Equatable with PerformanceTableState{
  final List<GetAssetClassEntity> getAssetClassEntities;
  

  GetAssetClassLoaded({
    required this.getAssetClassEntities,
    
  });

  @override
  List<Object?> get props => [
    getAssetClassEntities,
    
  ];
}
class GetBenchmarkLoaded extends Equatable with PerformanceTableState{
  final List<GetBenchmarkEntity> getBenchmarkEntities;
  

  GetBenchmarkLoaded({
    required this.getBenchmarkEntities,
    
  });

  @override
  List<Object?> get props => [
    getBenchmarkEntities,
    
  ];
}
class GetCustodianPerformanceLoaded extends Equatable with PerformanceTableState{
  final List<GetCustodianPerformanceEntity> getCustodianPerformanceEntities;
  

  GetCustodianPerformanceLoaded({
    required this.getCustodianPerformanceEntities,
    
  });

  @override
  List<Object?> get props => [
    getCustodianPerformanceEntities,
    
  ];
}

    