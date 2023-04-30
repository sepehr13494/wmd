import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/is_safe_device_params.dart';
import '../../domain/use_cases/is_safe_device_usecase.dart';
import '../../domain/entities/is_safe_device_entity.dart';


part 'safe_device_state.dart';

class SafeDeviceCubit extends Cubit<SafeDeviceState> {

  final IsSafeDeviceUseCase isSafeDeviceUseCase;


  SafeDeviceCubit(
    this.isSafeDeviceUseCase,
  ) : super(LoadingState());

  isSafeDevice() async {
    emit(LoadingState());
    final result = await isSafeDeviceUseCase(IsSafeDeviceParams());
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (entity) {
      
      emit(IsSafeDeviceLoaded(isSafeDeviceEntity: entity));
    });
  }
  

}

    