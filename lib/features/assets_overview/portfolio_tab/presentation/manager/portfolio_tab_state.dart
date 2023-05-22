part of 'portfolio_tab_cubit.dart';

abstract class PortfolioTabState {}

class GetPortfolioTabLoaded extends BaseAssetsOverviewLoaded<GetPortfolioTabEntity>{

  GetPortfolioTabLoaded({
    required List<GetPortfolioTabEntity> getPortfolioTabEntities,
  }) : super(assetsOverviewBaseModels: getPortfolioTabEntities);
}

    