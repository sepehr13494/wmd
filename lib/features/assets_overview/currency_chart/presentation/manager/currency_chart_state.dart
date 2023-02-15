part of 'currency_chart_cubit.dart';

abstract class CurrencyChartState {}

class GetCurrencyLoaded extends Equatable with CurrencyChartState{
  final List<GetCurrencyEntity> getCurrencyEntities;
  

  GetCurrencyLoaded({
    required this.getCurrencyEntities,
    
  });

  @override
  List<Object?> get props => [
    getCurrencyEntities,
    
  ];
}

    