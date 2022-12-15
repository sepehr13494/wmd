import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/get_all_valuation_params.dart';
import '../../domain/use_cases/get_all_valuation_usecase.dart';
import '../../domain/entities/get_all_valuation_entity.dart';
import '../../data/models/post_valuation_params.dart';
import '../../domain/use_cases/post_valuation_usecase.dart';

import '../../data/models/get_valuation_performance_params.dart';
import '../../domain/use_cases/get_valuation_performance_usecase.dart';
import '../../domain/entities/get_valuation_performance_entity.dart';

part 'valuation_state.dart';

class ValuationCubit extends Cubit<ValuationState> {
  final GetAllValuationUseCase getAllValuationUseCase;
  final PostValuationUseCase postValuationUseCase;
  final GetValuationPerformanceUseCase getValuationPerformanceUseCase;

  ValuationCubit(
    this.getAllValuationUseCase,
    this.postValuationUseCase,
    this.getValuationPerformanceUseCase,
  ) : super(LoadingState());

  getAllValuation() async {
    emit(LoadingState());
    final result = await getAllValuationUseCase(GetAllValuationParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (entities) {
      emit(GetAllValuationLoaded(getAllValuationEntities: entities));
    });
  }

  postValuation() async {
    emit(LoadingState());
    final result = await postValuationUseCase(PostValuationParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (appSuccess) {
      emit(SuccessState(appSuccess: appSuccess));
    });
  }

  getValuationPerformance() async {
    emit(LoadingState());
    final result =
        await getValuationPerformanceUseCase(GetValuationPerformanceParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (entities) {
      emit(GetValuationPerformanceLoaded(
          getValuationPerformanceEntities: entities));
    });
  }
}
