part of 'assets_geography_chart_cubit.dart';

abstract class AssetsGeographyChartState {}

class GetAssetsGeographyLoaded extends Equatable with AssetsGeographyChartState{
  final List<GetAssetsGeographyEntity> getAssetsGeographyEntities;
  

  GetAssetsGeographyLoaded({
    required this.getAssetsGeographyEntities,
    
  });

  @override
  List<Object?> get props => [
    getAssetsGeographyEntities,
    
  ];
}

    