import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/authentication/presentation/manager/authentication_cubit.dart';
import 'package:wmd/features/authentication/usecases/post_login_usecase.dart';

import 'authentication_cubit_test.mocks.dart';

@GenerateMocks([PostLoginUseCase])
void main() {
  late MockPostLoginUseCase mockPostLoginUseCase;
  late AuthenticationCubit authenticationCubit;

  setUp(() {
    mockPostLoginUseCase = MockPostLoginUseCase();
    authenticationCubit = AuthenticationCubit(mockPostLoginUseCase);
  });

  group('login cubit test', () {
    const tAppSuccess = AppSuccess(message: 'Login successful');
    final tLoginParams =
        LoginParams(email: 'test@yopmail.com', password: 'Passw0rd');
    blocTest(
      'when login use-case is returning App success bloc emits the success state',
      build: () => authenticationCubit,
      setUp: () => when(mockPostLoginUseCase(any))
          .thenAnswer((realInvocation) async => const Right(tAppSuccess)),
      act: (bloc) async => await bloc.postLogin(map: tLoginParams.toJson()),
      expect: () => [LoadingState, SuccessState(appSuccess: tAppSuccess)],
      verify: (_) {
        verify(mockPostLoginUseCase(tLoginParams)).called(1);
      },
    );
  });
}
