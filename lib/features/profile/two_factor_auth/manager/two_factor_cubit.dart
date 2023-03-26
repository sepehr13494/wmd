import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/settings/data/models/get_settings_params.dart';
import 'package:wmd/features/settings/data/models/put_settings_params.dart';
import 'package:wmd/features/settings/domain/entities/get_settings_entity.dart';
import 'package:wmd/features/settings/domain/use_cases/get_settings_usecase.dart';
import 'package:wmd/features/settings/domain/use_cases/put_settings_usecase.dart';

part 'two_factor_state.dart';

class TwoFactorCubit extends Cubit<TwoFactorState> {
  final GetSettingsUseCase getSettingsUseCase;
  final PutSettingsUseCase setBlurredUseCase;

  TwoFactorCubit(
    this.getSettingsUseCase,
    this.setBlurredUseCase,
  ) : super(LoadingState());

  getTwoFactor() async {
    final result =
        await getSettingsUseCase(GetSettingsParams.fromJson(const {}));
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(TwoFactorLoaded(entity: entity));
    });
  }

  setTwoFactor(PutSettingsParams params) async {
    final result = await setBlurredUseCase(params);
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(SuccessState(appSuccess: entity));
    });
  }
}
