import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/get_force_update_params.dart';
import '../../domain/use_cases/get_force_update_usecase.dart';
import '../../domain/entities/get_force_update_entity.dart';


part 'force_update_state.dart';

class ForceUpdateCubit extends Cubit<ForceUpdateState> {

  final GetForceUpdateUseCase getForceUpdateUseCase;


  ForceUpdateCubit(
    this.getForceUpdateUseCase,
  ) : super(LoadingState());

  getForceUpdate() async {
    emit(LoadingState());
    final result = await getForceUpdateUseCase(NoParams());
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (entity) {
      
      emit(GetForceUpdateLoaded(getForceUpdateEntity: entity));
    });
  }
  

}

    