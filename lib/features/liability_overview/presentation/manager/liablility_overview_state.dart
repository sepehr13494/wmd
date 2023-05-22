part of 'liablility_overview_cubit.dart';

abstract class LiablilityOverviewState {}

class GetLiabilityOverviewLoaded extends Equatable
    with LiablilityOverviewState {
  final List<GetLiablilityOverviewEntity> getLiablilityOverviewEntities;

  GetLiabilityOverviewLoaded({
    required this.getLiablilityOverviewEntities,
  });

  @override
  List<Object?> get props => [
        getLiablilityOverviewEntities,
      ];
}
