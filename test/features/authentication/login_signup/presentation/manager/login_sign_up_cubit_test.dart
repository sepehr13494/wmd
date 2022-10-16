import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/util/device_info.dart';
import 'package:wmd/features/authentication/login_signup/presentation/manager/login_sign_up_cubit.dart';
import 'package:wmd/features/authentication/login_signup/domain/use_cases/post_register_usecase.dart';
import 'package:wmd/features/authentication/login_signup/domain/use_cases/resend_email_usecase.dart';
import 'package:wmd/features/authentication/login_signup/domain/use_cases/post_login_usecase.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';

import 'login_sign_up_cubit_test.mocks.dart';

@GenerateMocks(
    [PostLoginUseCase, PostRegisterUseCase, ResendEmailUseCase, AppDeviceInfo])
void main() {
  late MockPostLoginUseCase mockPostLoginUseCase;
  late MockPostRegisterUseCase mockPostRegisterUseCase;
  late MockResendEmailUseCase mockResendEmailUseCase;
  late LoginSignUpCubit loginSignUpCubit;
  late MockAppDeviceInfo mockAppDeviceInfo;

  setUp(() {
    mockPostLoginUseCase = MockPostLoginUseCase();
    mockPostRegisterUseCase = MockPostRegisterUseCase();
    mockResendEmailUseCase = MockResendEmailUseCase();
    mockAppDeviceInfo = MockAppDeviceInfo();
    loginSignUpCubit = LoginSignUpCubit(mockPostLoginUseCase,
        mockPostRegisterUseCase, mockResendEmailUseCase, mockAppDeviceInfo);
  });

  group('login cubit test', () {
    const tAppSuccess = AppSuccess(message: 'Login successful');
    const tLoginParams =
        LoginParams(username: 'test@yopmail.com', password: 'Passw0rd');
    blocTest(
      'when login use-case is returning App success bloc emits the success state',
      build: () => loginSignUpCubit,
      setUp: () => when(mockPostLoginUseCase(any))
          .thenAnswer((realInvocation) async => const Right(tAppSuccess)),
      act: (bloc) async => await bloc.postLogin(map: tLoginParams.toJson()),
      expect: () =>
          [isA<LoadingState>(), SuccessState(appSuccess: tAppSuccess)],
      verify: (_) {
        verify(mockPostLoginUseCase(tLoginParams)).called(1);
      },
    );
  });

  group('register cubit test', () {
    const tAppSuccess = AppSuccess(message: 'Register successful');
    CustomizableDateTime.customTime = DateTime.now();
    blocTest(
      'when login use-case is returning App success bloc emits the success state',
      build: () => loginSignUpCubit,
      setUp: () {
        when(mockPostRegisterUseCase(any))
            .thenAnswer((realInvocation) async => const Right(tAppSuccess));
        when(mockAppDeviceInfo.getDeviceInfo())
            .thenAnswer((realInvocation) async => AppDeviceInfo.tAppDeviceInfo);
      },
      act: (bloc) async => await bloc.postRegister(map: RegisterParams.map),
      expect: () =>
          [isA<LoadingState>(), SuccessState(appSuccess: tAppSuccess)],
      verify: (_) {
        verify(mockPostRegisterUseCase(RegisterParams.tRegisterParams))
            .called(1);
      },
    );
  });

  group('resend email', () {
    const tAppSuccess = AppSuccess(message: 'Register successful');
    blocTest(
      'when resend email use-case is returning App success bloc emits the success state',
      build: () => loginSignUpCubit,
      setUp: () {
        when(mockResendEmailUseCase(any))
            .thenAnswer((realInvocation) async => const Right(tAppSuccess));
      },
      act: (bloc) async => await bloc.resendEmail(),
      expect: () =>
      [isA<LoadingState>(), SuccessState(appSuccess: tAppSuccess)],
      verify: (_) {
        verify(mockResendEmailUseCase(ResendEmailParams.tResendEmailParams))
            .called(1);
      },
    );
  });
}
