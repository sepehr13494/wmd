part of 'currency_cubit.dart';

abstract class CurrencyState {}

class GetCurrencyLoaded extends Equatable with CurrencyState {
  final GetCurrencyEntity getCurrencyEntity;

  GetCurrencyLoaded({
    required this.getCurrencyEntity,
  });

  @override
  List<Object?> get props => [
        getCurrencyEntity,
      ];
}
