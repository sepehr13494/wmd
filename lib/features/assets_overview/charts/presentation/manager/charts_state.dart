part of 'charts_cubit.dart';

abstract class ChartsState {}

class GetChartLoaded extends Equatable with ChartsState{
  final List<GetChartEntity> getChartEntities;
  

  GetChartLoaded({
    required this.getChartEntities,
    
  });

  @override
  List<Object?> get props => [
    getChartEntities,
    
  ];
}

    