    import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/authentication/logout/data/models/perform_logout_params.dart';
import 'package:wmd/features/authentication/logout/domain/use_cases/perform_logout_usecase.dart';
import 'package:wmd/features/authentication/logout/presentation/manager/logout_cubit.dart';

import 'logout_cubit_test.mocks.dart';



@GenerateMocks([
  PerformLogoutUseCase,

])
void main() {
  late MockPerformLogoutUseCase mockPerformLogoutUseCase;

  late LogoutCubit logoutCubit;


  setUp(() {
    mockPerformLogoutUseCase = MockPerformLogoutUseCase();

    logoutCubit = LogoutCubit(
    mockPerformLogoutUseCase,

    );
  });
  

  group("performLogout", () {
    blocTest(
      'when PerformLogoutUseCase emits the PerformLogoutLoaded when success',
      build: () => logoutCubit,
      setUp: () => when(mockPerformLogoutUseCase(any))
          .thenAnswer((realInvocation) async => Right(AppSuccess(message: "Successfully done"))),
      act: (bloc) async => await bloc.performLogout(),
      expect: () =>
      [isA<LoadingState>(), SuccessState(appSuccess: AppSuccess.tAppSuccess)],
      verify: (_) {
        verify(mockPerformLogoutUseCase(PerformLogoutParams.tParams));
      },
    );

    blocTest(
      'when PerformLogoutUseCase emits the ErrorState when error',
      build: () => logoutCubit,
      setUp: () => when(mockPerformLogoutUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.performLogout(),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockPerformLogoutUseCase(PerformLogoutParams.tParams));
      },
    );
  });

}

    