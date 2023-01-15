import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/models/time_filer_obj.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/injection_container.dart';

import '../../data/models/get_chart_params.dart';
import '../../domain/use_cases/get_chart_usecase.dart';
import '../../domain/entities/get_chart_entity.dart';


part 'charts_state.dart';

class ChartsCubit extends Cubit<ChartsState> {

  final GetChartUseCase getChartUseCase;


  ChartsCubit(
    this.getChartUseCase,
  ) : super(LoadingState());

  getChart({TimeFilterObj? dateTime}) async {
    emit(LoadingState());
    final result = await getChartUseCase(dateTime?? const TimeFilterObj(key: ".",value: 7));
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (entities) {
      
      emit(GetChartLoaded(getChartEntities: entities));
    });
  }
  

}

    