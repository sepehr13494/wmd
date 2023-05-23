import 'package:equatable/equatable.dart';
import 'package:wmd/features/assets_overview/portfolio_tab/presentation/manager/portfolio_tab_cubit.dart';

import '../../../assets_geography_chart/presentation/manager/assets_geography_chart_cubit.dart';
import '../../../assets_overview/presentation/manager/assets_overview_cubit.dart';
import '../../../currency_chart/presentation/manager/currency_chart_cubit.dart';
import '../../domain/entities/assets_overview_base_model.dart';

abstract class BaseAssetsOverviewState implements AssetsOverviewState,AssetsGeographyChartState,CurrencyChartState,PortfolioTabState{}

class BaseAssetsOverviewLoaded<T extends AssetsOverviewBaseModel> extends BaseAssetsOverviewState with EquatableMixin{
  final List<T> assetsOverviewBaseModels;

  BaseAssetsOverviewLoaded({required this.assetsOverviewBaseModels});

  @override
  List<Object?> get props => [
    assetsOverviewBaseModels
  ];
}
