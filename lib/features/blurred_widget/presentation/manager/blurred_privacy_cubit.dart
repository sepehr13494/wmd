import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import '../../data/models/get_is_blurred_params.dart';
import '../../domain/use_cases/get_is_blurred_usecase.dart';
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
    final result = await getIsBlurredUseCase(const GetIsBlurredParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(IsBlurredLoaded(isBlurred: entity.isBlurred));
    });
  }

  setBlurred(SetBlurredParams params) async {
    final result = await setBlurredUseCase(params);
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(IsBlurredLoaded(isBlurred: entity.isBlurred));
    });
  }
}
