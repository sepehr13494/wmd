part of 'portfolio_tab2_cubit.dart';

abstract class PortfolioTab2State {}

class GetPortfolioAllocationLoaded extends Equatable with PortfolioTab2State{
  final List<GetPortfolioAllocationEntity> getPortfolioAllocationEntities;
  

  GetPortfolioAllocationLoaded({
    required this.getPortfolioAllocationEntities,
    
  });

  @override
  List<Object?> get props => [
    getPortfolioAllocationEntities,
    
  ];
}
class GetPortfolioTabLoaded extends Equatable with PortfolioTab2State{
  final List<GetPortfolioTabEntity> getPortfolioTabEntities;
  

  GetPortfolioTabLoaded({
    required this.getPortfolioTabEntities,
    
  });

  @override
  List<Object?> get props => [
    getPortfolioTabEntities,
    
  ];
}

    