    import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/profile/profile_reset_password/data/models/reset_params.dart';
import 'package:wmd/features/profile/profile_reset_password/data/models/reset_response.dart';
import 'package:wmd/features/profile/profile_reset_password/domain/use_cases/reset_usecase.dart';
import 'package:wmd/features/profile/profile_reset_password/presentation/manager/profile_reset_password_cubit.dart';

import 'profile_reset_password_cubit_test.mocks.dart';



@GenerateMocks([
  ResetUseCase,

])
void main() {
  late MockResetUseCase mockResetUseCase;

  late ProfileResetPasswordCubit profileResetPasswordCubit;


  setUp(() {
    mockResetUseCase = MockResetUseCase();

    profileResetPasswordCubit = ProfileResetPasswordCubit(
    mockResetUseCase,

    );
  });
  

  group("reset", () {
    blocTest(
      'when ResetUseCase emits the ResetLoaded when success',
      build: () => profileResetPasswordCubit,
      setUp: () => when(mockResetUseCase(any))
          .thenAnswer((realInvocation) async => const Right(AppSuccess())),
      act: (bloc) async => await bloc.reset(map: ResetParams.tParams.toJson()),
      expect: () =>
      [isA<LoadingState>(), SuccessState(appSuccess: AppSuccess.tAppSuccess)],
      verify: (_) {
        verify(mockResetUseCase(ResetParams.tParams));
      },
    );

    blocTest(
      'when ResetUseCase emits the ErrorState when error',
      build: () => profileResetPasswordCubit,
      setUp: () => when(mockResetUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.reset(map: ResetParams.tParams.toJson()),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockResetUseCase(ResetParams.tParams));
      },
    );
  });

}

    