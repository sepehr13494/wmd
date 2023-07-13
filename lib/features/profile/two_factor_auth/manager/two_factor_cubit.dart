import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/util/firebase_analytics.dart';
import 'package:wmd/features/settings/core/data/models/get_settings_params.dart';
import 'package:wmd/features/settings/core/data/models/put_settings_params.dart';
import 'package:wmd/features/settings/core/domain/entities/get_settings_entity.dart';
import 'package:wmd/features/settings/core/domain/use_cases/get_settings_usecase.dart';
import 'package:wmd/features/settings/core/domain/use_cases/put_settings_usecase.dart';

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
    if (params.twoFactorEnabled == true) {
      AnalyticsUtils.triggerEvent(
          action: AnalyticsUtils.enable2FAAction,
          params: AnalyticsUtils.enable2FAEvent);
    } else {
      AnalyticsUtils.triggerEvent(
          action: AnalyticsUtils.disable2FAAction,
          params: AnalyticsUtils.disable2FAEvent);
    }

    final result = await setBlurredUseCase(params);
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(SuccessState(
          appSuccess: AppSuccess(
              message: ((params.twoFactorEnabled != null &&
                          params.twoFactorEnabled == true) ||
                      (params.emailTwoFactorEnabled != null &&
                          params.emailTwoFactorEnabled == true) ||
                      (params.smsTwoFactorEnabled != null &&
                          params.smsTwoFactorEnabled == true))
                  ? "profile_twoFactorAuthentication_toast_on"
                  : "profile_twoFactorAuthentication_toast_off")));
    });
  }
}
