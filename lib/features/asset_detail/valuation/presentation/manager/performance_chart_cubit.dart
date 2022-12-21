import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/get_valuation_performance_params.dart';
import '../../domain/use_cases/get_valuation_performance_usecase.dart';
import '../../domain/entities/get_valuation_performance_entity.dart';

part 'performance_chart_state.dart';

class PerformanceChartCubit extends Cubit<PerformanceChartState> {
  final GetValuationPerformanceUseCase getValuationPerformanceUseCase;

  PerformanceChartCubit(
    this.getValuationPerformanceUseCase,
  ) : super(LoadingState());

  getValuationPerformance(GetValuationPerformanceParams params) async {
    emit(LoadingState());
    final result = await getValuationPerformanceUseCase(params);
    result.fold((failure) => emit(ErrorState(failure: failure)), (entities) {
      emit(PerformanceLoaded(getValuationPerformanceEntities: entities));
    });
  }
}
