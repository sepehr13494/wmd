import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/assets_overview/portfolio_tab2/presentation/manager/portfolio_tab2_cubit.dart';

part 'portfolio_provider_container_state.dart';

class PortfolioProviderContainerCubit extends Cubit<PortfolioProviderContainerState> {
  PortfolioProviderContainerCubit() : super(LoadingState());

  addBlocs({required List<PortfolioTab2CubitForTab> blocs,required List<String> names}){
    emit(PortfolioProviderContainerLoaded(portfolioCubits: blocs,names: names));
  }
}
