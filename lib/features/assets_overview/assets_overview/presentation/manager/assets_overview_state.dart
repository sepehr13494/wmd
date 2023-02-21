part of 'assets_overview_cubit.dart';

abstract class AssetsOverviewState {}

class AssetsOverviewLoaded extends BaseAssetsOverviewLoaded<AssetsOverviewEntity> {
  AssetsOverviewLoaded({required List<AssetsOverviewEntity> assetsOverviews})
      : super(assetsOverviewBaseModels: assetsOverviews);
}
