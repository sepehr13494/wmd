import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/assets_overview/core/presentataion/manager/base_assets_overview_state.dart';

import '../../data/models/get_portfolio_allocation_params.dart';
import '../../domain/use_cases/get_portfolio_allocation_usecase.dart';
import '../../domain/entities/get_portfolio_allocation_entity.dart';
import '../../data/models/get_portfolio_tab_params.dart';
import '../../domain/use_cases/get_portfolio_tab_usecase.dart';
import '../../domain/entities/get_portfolio_tab_entity.dart';


part 'portfolio_tab2_state.dart';

class PortfolioTab2Cubit extends Cubit<PortfolioTab2State> {

  final GetPortfolioAllocationUseCase getPortfolioAllocationUseCase;
  final GetPortfolioTabUseCase getPortfolioTabUseCase;

  List<GetPortfolioTabEntity> finalEntities = [];

  PortfolioTab2Cubit(
    this.getPortfolioAllocationUseCase,
    this.getPortfolioTabUseCase,
  ) : super(LoadingState());

  getPortfolioAllocation() async {
    emit(LoadingState());
    final result = await getPortfolioAllocationUseCase();
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (entities) {
          entities.sort((a, b) {
            return (b.value - a.value).toInt();
          },);
      emit(GetPortfolioAllocationLoaded(getPortfolioAllocationEntities: entities));
    });
  }
  
  getPortfolioTab({required String portfolioId}) async {
    emit(LoadingState());
    getPortfolioTabUseCase(portfolioId).then((value) {
      value.fold((failure) => emit(ErrorState(failure: failure)),
              (entities) {
        for (var element in entities) {
          element.assetList.sort((a, b) {
            return (b.currentValue - a.currentValue).toInt();
          },);
        }
            emit(GetPortfolioTabLoaded(getPortfolioTabEntity: entities));
          });
    });
  }

}

class PortfolioTab2CubitForTab extends PortfolioTab2Cubit{
  PortfolioTab2CubitForTab(super.getPortfolioAllocationUseCase, super.getPortfolioTabUseCase);
}

    