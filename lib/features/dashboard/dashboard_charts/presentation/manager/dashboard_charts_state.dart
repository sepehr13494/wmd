part of 'dashboard_charts_cubit.dart';

abstract class DashboardChartsState {}

class GetAllocationLoaded extends Equatable with DashboardChartsState{
  final List<GetAllocationEntity> getAllocationEntity;


  GetAllocationLoaded({
    required this.getAllocationEntity,
  });

  @override
  List<Object?> get props => [
    getAllocationEntity,
  ];
}

class GetGeographicLoaded extends Equatable with DashboardChartsState{
  final List<GetGeographicEntity> getGeographicEntity;


  GetGeographicLoaded({
    required this.getGeographicEntity,
  });

  @override
  List<Object?> get props => [
    getGeographicEntity,
  ];
}

class GetPieLoaded extends Equatable with DashboardChartsState{
  final List<GetPieEntity> getPieEntity;


  GetPieLoaded({
    required this.getPieEntity,
  });

  @override
  List<Object?> get props => [
    getPieEntity,
  ];
}
    