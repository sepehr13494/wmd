part of 'assets_geography_chart_cubit.dart';

abstract class AssetsGeographyChartState {}

class GetAssetsGeographyLoaded extends BaseAssetsOverviewLoaded<GetAssetsGeographyEntity>{

  GetAssetsGeographyLoaded({
    required List<GetAssetsGeographyEntity> getAssetsGeographyEntities,
  }) : super(assetsOverviewBaseModels: getAssetsGeographyEntities);
}

    