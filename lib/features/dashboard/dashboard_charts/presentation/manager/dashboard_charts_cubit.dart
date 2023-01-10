import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/models/time_filer_obj.dart';
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

  getAllocation({TimeFilterObj? dateTime}) async {
    emit(LoadingState());
    final result = await getAllocationUseCase(dateTime?? const TimeFilterObj(key: "",value: 7));
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
          entities.sort((a, b) => (b.amount - a.amount).toInt());
          emit(GetGeographicLoaded(getGeographicEntity: entities));
    });
  }
  
  getPie() async {
    emit(LoadingState());
    final result = await getPieUseCase(NoParams());
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (entities) {
          entities.sort((a, b) => (b.value - a.value).toInt());
          emit(GetPieLoaded(getPieEntity: entities));
    });
  }
  

}

    