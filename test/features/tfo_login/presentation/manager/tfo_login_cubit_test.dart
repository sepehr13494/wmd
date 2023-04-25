import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/add_assets/tfo_login/data/models/get_mandates_params.dart';
import 'package:wmd/features/add_assets/tfo_login/data/models/login_tfo_account_params.dart';
import 'package:wmd/features/add_assets/tfo_login/domain/use_cases/get_mandates_usecase.dart';
import 'package:wmd/features/add_assets/tfo_login/domain/use_cases/login_tfo_account_usecase.dart';
import 'package:wmd/features/add_assets/tfo_login/presentation/manager/tfo_login_cubit.dart';

import 'tfo_login_cubit_test.mocks.dart';

@GenerateMocks([
  GetMandatesUseCase,
  LoginTfoAccountUseCase,
])
void main() {
  late MockGetMandatesUseCase mockGetMandatesUseCase;
  late MockLoginTfoAccountUseCase mockLoginTfoAccountUseCase;

  late TfoLoginCubit tfoLoginCubit;

  setUp(() {
    mockGetMandatesUseCase = MockGetMandatesUseCase();
    mockLoginTfoAccountUseCase = MockLoginTfoAccountUseCase();

    tfoLoginCubit = TfoLoginCubit(
      mockGetMandatesUseCase,
      mockLoginTfoAccountUseCase,
    );
  });

  group("getMandates", () {
    blocTest(
      'when GetMandatesUseCase emits the GetMandatesLoaded when success',
      build: () => tfoLoginCubit,
      setUp: () => when(mockGetMandatesUseCase(any)).thenAnswer(
          (realInvocation) async =>
              Right(AppSuccess(message: "successfully done"))),
      act: (bloc) async => await bloc.getMandates(),
      expect: () => [
        isA<LoadingState>(),
        SuccessState(appSuccess: AppSuccess.tAppSuccess)
      ],
      verify: (_) {
        verify(mockGetMandatesUseCase(GetMandatesParams.tParams));
      },
    );

    blocTest(
      'when GetMandatesUseCase emits the ErrorState when error',
      build: () => tfoLoginCubit,
      setUp: () => when(mockGetMandatesUseCase(any)).thenAnswer(
          (realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.getMandates(),
      expect: () => [
        isA<LoadingState>(),
        ErrorState(failure: ServerFailure.tServerFailure)
      ],
      verify: (_) {
        verify(mockGetMandatesUseCase(GetMandatesParams.tParams));
      },
    );
  });
  group("loginTfoAccount", () {
    blocTest(
      'when LoginTfoAccountUseCase emits the LoginTfoAccountLoaded when success',
      build: () => tfoLoginCubit,
      setUp: () => when(mockLoginTfoAccountUseCase(any)).thenAnswer(
          (realInvocation) async =>
              Right(AppSuccess(message: "successfully done"))),
      act: (bloc) async => await bloc.loginTfoAccount(),
      expect: () => [
        isA<LoadingState>(),
        SuccessState(appSuccess: AppSuccess.tAppSuccess)
      ],
      verify: (_) {
        verify(mockLoginTfoAccountUseCase(LoginTfoAccountParams.tParams));
      },
    );

    blocTest(
      'when LoginTfoAccountUseCase emits the ErrorState when error',
      build: () => tfoLoginCubit,
      setUp: () => when(mockLoginTfoAccountUseCase(any)).thenAnswer(
          (realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.loginTfoAccount(),
      expect: () => [
        isA<LoadingState>(),
        ErrorState(failure: ServerFailure.tServerFailure)
      ],
      verify: (_) {
        verify(mockLoginTfoAccountUseCase(LoginTfoAccountParams.tParams));
      },
    );
  });
}
