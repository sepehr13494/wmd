part of 'liablility_overview_cubit.dart';

abstract class LiablilityOverviewState {}

class GetLiablilityOverviewLoaded extends Equatable with LiablilityOverviewState{
  final List<GetLiablilityOverviewEntity> getLiablilityOverviewEntities;
  

  GetLiablilityOverviewLoaded({
    required this.getLiablilityOverviewEntities,
    
  });

  @override
  List<Object?> get props => [
    getLiablilityOverviewEntities,
    
  ];
}

    