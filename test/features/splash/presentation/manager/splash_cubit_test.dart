import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/splash/domain/use_cases/check_login_usecase.dart';
import 'package:wmd/features/splash/presentation/manager/splash_cubit.dart';

import 'splash_cubit_test.mocks.dart';

@GenerateMocks([CheckLoginUseCase])
void main() {
  late MockCheckLoginUseCase mockCheckLoginUseCase;
  late SplashCubit splashCubit;

  setUp(() {
    mockCheckLoginUseCase = MockCheckLoginUseCase();
    splashCubit = SplashCubit(mockCheckLoginUseCase);
  });

  group('splash cubit test', () {
    blocTest(
      'when isLogin is false navigate to LoginPage',
      build: () => splashCubit,
      setUp: () => when(mockCheckLoginUseCase(any)).thenAnswer((realInvocation) async => const Right(false)),
      act: (bloc)=>bloc.initSplash(),
      wait: const Duration(seconds: 2),
      expect: () => [isA<SplashLoaded>().having((state) => state.isLogin, 'isLogin', false)],
      verify: (_) {
        verify(mockCheckLoginUseCase(NoParams())).called(1);
      },
    );

    blocTest(
      'when isLogin is true navigate to MainPage',
      build: () => splashCubit,
      setUp: () => when(mockCheckLoginUseCase(any)).thenAnswer((realInvocation) async => const Right(true)),
      act: (bloc)=>bloc.initSplash(),
      wait: const Duration(seconds: 2),
      expect: () => [isA<SplashLoaded>().having((state) => state.isLogin, 'isLogin', true)],
      verify: (_) {
        verify(mockCheckLoginUseCase(NoParams())).called(1);
      },
    );

    const tFailure = CacheFailure(message: "test");

    blocTest(
      'when isLogin returns Failure emits ErrorState with Failure message',
      build: () => splashCubit,
      setUp: () => when(mockCheckLoginUseCase(any)).thenAnswer((realInvocation) async => const Left(tFailure)),
      act: (bloc)=>bloc.initSplash(),
      wait: const Duration(seconds: 2),
      expect: () => [isA<ErrorState>().having((state) => state.failure, 'failure', tFailure)],
      verify: (_) {
        verify(mockCheckLoginUseCase(NoParams())).called(1);
      },
    );
  });
}
