part of 'assets_overview_cubit.dart';

abstract class AssetsOverviewState {}

class AssetsOverviewLoaded extends Equatable with AssetsOverviewState {
  final List<AssetsOverviewEntity> assetsOverviews;

  AssetsOverviewLoaded({required this.assetsOverviews});

  @override
  List<Object> get props => [assetsOverviews];
}