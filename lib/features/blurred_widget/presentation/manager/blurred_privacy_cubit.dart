import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/get_is_blurred_params.dart';
import '../../domain/use_cases/get_is_blurred_usecase.dart';
import '../../domain/entities/is_blurred_entity.dart';
import '../../data/models/set_blurred_params.dart';
import '../../domain/use_cases/set_blurred_usecase.dart';

part 'blurred_privacy_state.dart';

class BlurredPrivacyCubit extends Cubit<BlurredPrivacyState> {
  final GetIsBlurredUseCase getIsBlurredUseCase;
  final SetBlurredUseCase setBlurredUseCase;

  BlurredPrivacyCubit(
    this.getIsBlurredUseCase,
    this.setBlurredUseCase,
  ) : super(LoadingState());

  getIsBlurred() async {
    emit(LoadingState());
    final result = await getIsBlurredUseCase(const GetIsBlurredParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(IsBlurredLoaded(isBlurredEntity: entity));
    });
  }

  setBlurred() async {
    emit(LoadingState());
    final result = await setBlurredUseCase(SetBlurredParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(IsBlurredLoaded(isBlurredEntity: entity));
    });
  }
}
