import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../../assets_geography_chart/presentation/manager/assets_geography_chart_cubit.dart';
import '../../../core/presentataion/manager/base_assets_overview_state.dart';
import '../../data/models/get_portfolio_tab_params.dart';
import '../../domain/use_cases/get_portfolio_tab_usecase.dart';
import '../../domain/entities/get_portfolio_tab_entity.dart';


part 'portfolio_tab_state.dart';

class PortfolioTabCubit extends Cubit<AssetsGeographyChartState> {

  final GetPortfolioTabUseCase getPortfolioTabUseCase;


  PortfolioTabCubit(
    this.getPortfolioTabUseCase,
  ) : super(LoadingState());

  getPortfolioTab() async {
    emit(LoadingState());
    final result = await getPortfolioTabUseCase(GetPortfolioTabParams());
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (entities) {
      
      emit(GetPortfolioTabLoaded(getPortfolioTabEntities: entities));
    });
  }
  

}

    