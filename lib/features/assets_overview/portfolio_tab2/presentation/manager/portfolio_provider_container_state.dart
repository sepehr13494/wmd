part of 'portfolio_provider_container_cubit.dart';

@immutable
abstract class PortfolioProviderContainerState {}

class PortfolioProviderContainerLoaded extends PortfolioProviderContainerState {
  final List<PortfolioTab2CubitForTab> portfolioCubits;
  final List<String> names;

  PortfolioProviderContainerLoaded({required this.portfolioCubits,required this.names});

}
