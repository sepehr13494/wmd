import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/util/firebase_analytics.dart';
import 'package:wmd/features/authentication/forget_password/domain/use_cases/forget_password_usecase.dart';
import 'package:wmd/features/authentication/forget_password/domain/use_cases/reset_password_usecase.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<BaseState> {
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  ForgetPasswordCubit(this.forgetPasswordUseCase, this.resetPasswordUseCase)
      : super(BaseInitialState());

  forgetPassword({required Map<String, dynamic> map}) async {
    emit(LoadingState());

    await AnalyticsUtils.triggerEvent(
        action: AnalyticsUtils.forgotPasswordAction,
        params: AnalyticsUtils.forgotPasswordEvent);

    final verifyEmailParams = ForgetPasswordParams.fromJson(map);
    final result = await forgetPasswordUseCase(verifyEmailParams);
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) => emit(SuccessState(appSuccess: appSuccess)));
  }

  resetPassword({required Map<String, dynamic> map}) async {
    emit(LoadingState());

    await AnalyticsUtils.triggerEvent(
        action: AnalyticsUtils.forgotPasswordAction,
        params: AnalyticsUtils.resetPasswordEvent);

    final data = ResetPasswordParams.fromJson(map);
    final result = await resetPasswordUseCase(data);
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) => emit(SuccessState(appSuccess: appSuccess)));
  }
}
