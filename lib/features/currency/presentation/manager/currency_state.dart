part of 'currency_cubit.dart';

abstract class CurrencyState {}

class GetCurrencyConversionLoaded extends Equatable with CurrencyState {
  final GetCurrencyConversionEntity getCurrencyEntity;

  GetCurrencyConversionLoaded({
    required this.getCurrencyEntity,
  });

  @override
  List<Object?> get props => [
        getCurrencyEntity,
      ];
}
