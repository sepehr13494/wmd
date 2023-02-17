import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/get_currency_params.dart';
import '../../domain/use_cases/get_currency_usecase.dart';
import '../../domain/entities/get_currency_entity.dart';


part 'currency_chart_state.dart';

class CurrencyChartCubit extends Cubit<CurrencyChartState> {

  final GetCurrencyUseCase getCurrencyUseCase;


  CurrencyChartCubit(
    this.getCurrencyUseCase,
  ) : super(LoadingState());

  getCurrency() async {
    emit(LoadingState());
    final result = await getCurrencyUseCase(NoParams());
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (entities) {
      emit(GetCurrencyLoaded(getCurrencyEntities: entities));
    });
  }
  

}

    