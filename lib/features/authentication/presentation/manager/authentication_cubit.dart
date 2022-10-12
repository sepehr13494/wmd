import 'package:bloc/bloc.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/util/device_info.dart';
import 'package:wmd/features/authentication/domain/use_cases/post_login_usecase.dart';
import 'package:wmd/features/authentication/domain/use_cases/post_register_usecase.dart';
import 'package:wmd/injection_container.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final PostLoginUseCase postLoginUseCase;
  final PostRegisterUseCase postRegisterUseCase;
  final AppDeviceInfo appDeviceInfo;
  AuthenticationCubit(
      this.postLoginUseCase, this.postRegisterUseCase, this.appDeviceInfo)
      : super(AuthenticationInitial());

  postLogin({required Map<String, dynamic> map}) async {
    emit(LoadingState());
    final result = await postLoginUseCase(LoginParams.fromJson(map));
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) => emit(SuccessState(appSuccess: appSuccess)));
  }

  postRegister({required Map<String, dynamic> map}) async {
    emit(LoadingState());
    final registerParamsForApi = RegisterParams.fromJson(map);
    final appDeviceInfoModel = await appDeviceInfo.getDeviceInfo();
    final termsAndCondition = TermsOfService(
        agreedAt: CustomizableDateTime.current.toString(),
        userAgent: appDeviceInfoModel.deviceName,
        ipAddress: appDeviceInfoModel.ip);
    registerParamsForApi.termsOfService = termsAndCondition;

    final result = await postRegisterUseCase(registerParamsForApi);
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) => emit(SuccessState(appSuccess: appSuccess)));
  }
}
