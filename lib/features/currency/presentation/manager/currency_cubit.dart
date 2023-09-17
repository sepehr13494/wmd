import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/get_currency_params.dart';
import '../../domain/use_cases/get_currency_usecase.dart';
import '../../domain/entities/get_currency_entity.dart';

part 'currency_state.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  final GetCurrencyConversionUseCase getCurrencyUseCase;

  CurrencyCubit(
    this.getCurrencyUseCase,
  ) : super(LoadingState());

  getCurrency(String fromCurrency, String toCurrency) async {
    emit(LoadingState());
    final result = await getCurrencyUseCase(GetCurrencyConversionParams(
        fromCurrency: fromCurrency, toCurrency: toCurrency));
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(GetCurrencyConversionLoaded(getCurrencyEntity: entity));
    });
  }
}
