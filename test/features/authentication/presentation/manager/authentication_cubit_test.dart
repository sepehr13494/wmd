import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/util/device_info.dart';
import 'package:wmd/features/authentication/domain/use_cases/post_register_usecase.dart';
import 'package:wmd/features/authentication/presentation/manager/authentication_cubit.dart';
import 'package:wmd/features/authentication/domain/use_cases/post_login_usecase.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';

import 'authentication_cubit_test.mocks.dart';

@GenerateMocks([PostLoginUseCase, PostRegisterUseCase, AppDeviceInfo])
void main() {
  late MockPostLoginUseCase mockPostLoginUseCase;
  late MockPostRegisterUseCase mockPostRegisterUseCase;
  late AuthenticationCubit authenticationCubit;
  late MockAppDeviceInfo mockAppDeviceInfo;

  setUp(() {
    mockPostLoginUseCase = MockPostLoginUseCase();
    mockPostRegisterUseCase = MockPostRegisterUseCase();
    mockAppDeviceInfo = MockAppDeviceInfo();
    authenticationCubit = AuthenticationCubit(
        mockPostLoginUseCase, mockPostRegisterUseCase, mockAppDeviceInfo);
  });

  group('login cubit test', () {
    const tAppSuccess = AppSuccess(message: 'Login successful');
    const tLoginParams =
        LoginParams(username: 'test@yopmail.com', password: 'Passw0rd');
    blocTest(
      'when login use-case is returning App success bloc emits the success state',
      build: () => authenticationCubit,
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
      build: () => authenticationCubit,
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
}
