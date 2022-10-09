import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/authentication/domain/use_cases/post_register_usecase.dart';
import 'package:wmd/features/authentication/presentation/manager/authentication_cubit.dart';
import 'package:wmd/features/authentication/domain/use_cases/post_login_usecase.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';

import 'authentication_cubit_test.mocks.dart';

@GenerateMocks([PostLoginUseCase, PostRegisterUseCase])
void main() {
  late MockPostLoginUseCase mockPostLoginUseCase;
  late MockPostRegisterUseCase mockPostRegisterUseCase;
  late AuthenticationCubit authenticationCubit;

  setUp(() {
    mockPostLoginUseCase = MockPostLoginUseCase();
    mockPostRegisterUseCase = MockPostRegisterUseCase();
    authenticationCubit =
        AuthenticationCubit(mockPostLoginUseCase, mockPostRegisterUseCase);
  });

  group('login cubit test', () {
    const tAppSuccess = AppSuccess(message: 'Login successful');
    const tLoginParams = LoginParams(email: 'test@yopmail.com', password: 'Passw0rd');
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
    final tTermsOfService = TermsOfService(agreedAt: CustomizableDateTime.current.toString());
    final map = {
      "email": 'test@yopmail.com',
      "password": 'Passw0rd',
    };
    final tRegisterParams = RegisterParams(
        email: 'test@yopmail.com',
        password: 'Passw0rd',
        termsOfService: tTermsOfService);
    blocTest(
      'when login use-case is returning App success bloc emits the success state',
      build: () => authenticationCubit,
      setUp: () => when(mockPostRegisterUseCase(any))
          .thenAnswer((realInvocation) async => const Right(tAppSuccess)),
      act: (bloc) async =>
          await bloc.postRegister(map: map),
      expect: () =>
          [isA<LoadingState>(), SuccessState(appSuccess: tAppSuccess)],
      verify: (_) {
        verify(mockPostRegisterUseCase(tRegisterParams)).called(1);
      },
    );
  });
}
