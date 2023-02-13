import 'package:bloc/bloc.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/util/device_info.dart';
import 'package:wmd/core/util/firebase_analytics.dart';
import 'package:wmd/features/authentication/login_signup/domain/use_cases/post_login_usecase.dart';
import 'package:wmd/features/authentication/login_signup/domain/use_cases/post_register_usecase.dart';
import 'package:wmd/features/authentication/login_signup/domain/use_cases/resend_email_usecase.dart';
import 'package:wmd/features/dashboard/user_status/domain/use_cases/get_user_status_usecase.dart';

part 'login_sign_up_state.dart';

class LoginSignUpCubit extends Cubit<LoginSignUpState> {
  final PostLoginUseCase postLoginUseCase;
  final PostRegisterUseCase postRegisterUseCase;
  final ResendEmailUseCase resendEmailUseCase;
  final AppDeviceInfo appDeviceInfo;
  final GetUserStatusUseCase getUserStatusUseCase;

  LoginSignUpCubit(
    this.postLoginUseCase,
    this.postRegisterUseCase,
    this.resendEmailUseCase,
    this.appDeviceInfo,
    this.getUserStatusUseCase,
  ) : super(LoginSignUpInitial());

  postLogin({required Map<String, dynamic> map}) async {
    emit(LoadingState());
    await AnalyticsUtils.triggerEvent(
        action: AnalyticsUtils.loginAction,
        params: AnalyticsUtils.loginStartedEvent);
    final result = await postLoginUseCase(LoginParams.fromJson(map));
    //TODO: Call get user usecase and manage navigation for the not verified
    // TODO Create Login loaded state pass the route
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) => emit(SuccessState(appSuccess: appSuccess)));
  }

  postRegister({required Map<String, dynamic> map}) async {
    emit(LoadingState());
    await AnalyticsUtils.triggerEvent(
        action: AnalyticsUtils.signUpAction,
        params: AnalyticsUtils.signUpStartEvent);

    final registerParamsForApi = RegisterParams.fromJson(map);
    final appDeviceInfoModel = await appDeviceInfo.getDeviceInfo();
    final termsAndCondition = TermsOfService(
        agreedAt: CustomizableDateTime.current.toString(),
        userAgent: appDeviceInfoModel.deviceName,
        ipAddress: appDeviceInfoModel.ip);
    registerParamsForApi.termsOfService = termsAndCondition;

    final result = await postRegisterUseCase(registerParamsForApi);
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) async {
      final res = await getUserStatusUseCase(NoParams());

      res.fold((failure) {
        emit(ErrorState(failure: failure));
      }, (userStatusSuccess) {
        if (userStatusSuccess.emailVerified == true) {
          emit(SuccessState(appSuccess: const AppSuccess(message: 'true')));
        } else {
          emit(SuccessState(appSuccess: const AppSuccess(message: 'false')));
        }

        // emit(UserStatusLoaded(userStatus: userStatusSuccess));
      });
      // emit(SuccessState(appSuccess: appSuccess));
    });
  }

  resendEmail() async {
    emit(LoadingState());
    final resendEmailParams = ResendEmailParams.fromJson({});
    final result = await resendEmailUseCase(resendEmailParams);
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) => emit(SuccessState(appSuccess: appSuccess)));
  }
}
