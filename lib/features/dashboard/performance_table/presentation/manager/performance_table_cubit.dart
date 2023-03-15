import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/get_asset_class_params.dart';
import '../../domain/use_cases/get_asset_class_usecase.dart';
import '../../domain/entities/get_asset_class_entity.dart';
import '../../data/models/get_benchmark_params.dart';
import '../../domain/use_cases/get_benchmark_usecase.dart';
import '../../domain/entities/get_benchmark_entity.dart';
import '../../data/models/get_custodian_performance_params.dart';
import '../../domain/use_cases/get_custodian_performance_usecase.dart';
import '../../domain/entities/get_custodian_performance_entity.dart';


part 'performance_table_state.dart';

class PerformanceTableCubit extends Cubit<PerformanceTableState> {

  final GetAssetClassUseCase getAssetClassUseCase;
  final GetBenchmarkUseCase getBenchmarkUseCase;
  final GetCustodianPerformanceUseCase getCustodianPerformanceUseCase;


  PerformanceTableCubit(
    this.getAssetClassUseCase,
    this.getBenchmarkUseCase,
    this.getCustodianPerformanceUseCase,
  ) : super(LoadingState());

  getAssetClass() async {
    emit(LoadingState());
    final result = await getAssetClassUseCase(GetAssetClassParams());
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (entities) {
      
      emit(GetAssetClassLoaded(getAssetClassEntities: entities));
    });
  }
  
  getBenchmark() async {
    emit(LoadingState());
    final result = await getBenchmarkUseCase(GetBenchmarkParams());
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (entities) {
      
      emit(GetBenchmarkLoaded(getBenchmarkEntities: entities));
    });
  }
  
  getCustodianPerformance() async {
    emit(LoadingState());
    final result = await getCustodianPerformanceUseCase(GetCustodianPerformanceParams());
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (entities) {
      
      emit(GetCustodianPerformanceLoaded(getCustodianPerformanceEntities: entities));
    });
  }
  

}

    