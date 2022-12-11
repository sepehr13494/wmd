import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../domain/use_cases/get_allocation_usecase.dart';
import '../../domain/entities/get_allocation_entity.dart';
import '../../domain/use_cases/get_geographic_usecase.dart';
import '../../domain/entities/get_geographic_entity.dart';
import '../../domain/use_cases/get_pie_usecase.dart';
import '../../domain/entities/get_pie_entity.dart';


part 'dashboard_charts_state.dart';

class DashboardChartsCubit extends Cubit<DashboardChartsState> {

  final GetAllocationUseCase getAllocationUseCase;
  final GetGeographicUseCase getGeographicUseCase;
  final GetPieUseCase getPieUseCase;


  DashboardChartsCubit(
    this.getAllocationUseCase,
    this.getGeographicUseCase,
    this.getPieUseCase,
  ) : super(LoadingState());

  getAllocation() async {
    emit(LoadingState());
    final result = await getAllocationUseCase(NoParams());
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (entities) {
      emit(GetAllocationLoaded(getAllocationEntity: entities));
    });
  }
  
  getGeographic() async {
    emit(LoadingState());
    final result = await getGeographicUseCase(NoParams());
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (entities) {
          emit(GetGeographicLoaded(getGeographicEntity: entities));
    });
  }
  
  getPie() async {
    emit(LoadingState());
    final result = await getPieUseCase(NoParams());
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (entities) {
          emit(GetPieLoaded(getPieEntity: entities));
    });
  }
  

}

    