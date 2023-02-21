part of 'currency_chart_cubit.dart';

abstract class CurrencyChartState {}

class GetCurrencyLoaded extends BaseAssetsOverviewLoaded<GetCurrencyEntity>{

  GetCurrencyLoaded({
    required List<GetCurrencyEntity> getCurrencyEntities,
  }) : super(assetsOverviewBaseModels: getCurrencyEntities);

}

    