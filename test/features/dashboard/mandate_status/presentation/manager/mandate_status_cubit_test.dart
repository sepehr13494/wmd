import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/dashboard/mandate_status/data/models/delete_mandate_params.dart';
import 'package:wmd/features/dashboard/mandate_status/data/models/get_mandate_status_params.dart';
import 'package:wmd/features/dashboard/mandate_status/data/models/get_mandate_status_response.dart';
import 'package:wmd/features/dashboard/mandate_status/domain/use_cases/delete_mandate_usecase.dart';
import 'package:wmd/features/dashboard/mandate_status/domain/use_cases/get_mandate_status_usecase.dart';
import 'package:wmd/features/dashboard/mandate_status/presentation/manager/mandate_status_cubit.dart';

import 'mandate_status_cubit_test.mocks.dart';

@GenerateMocks([
  GetMandateStatusUseCase,
  DeleteMandateUseCase,
])
void main() {
  late MockGetMandateStatusUseCase mockGetMandateStatusUseCase;
  late MockDeleteMandateUseCase mockDeleteMandateUseCase;

  late MandateStatusCubit mandateStatusCubit;

  setUp(() {
    mockGetMandateStatusUseCase = MockGetMandateStatusUseCase();
    mockDeleteMandateUseCase = MockDeleteMandateUseCase();

    mandateStatusCubit = MandateStatusCubit(
      mockGetMandateStatusUseCase,
      mockDeleteMandateUseCase,
    );
  });

  group("getMandateStatus", () {
    blocTest(
      'when GetMandateStatusUseCase emits the GetMandateStatusLoaded when success',
      build: () => mandateStatusCubit,
      setUp: () => when(mockGetMandateStatusUseCase(any)).thenAnswer(
          (realInvocation) async => Right(GetMandateStatusResponse.tResponse)),
      act: (bloc) async => await bloc.getMandateStatus(),
      expect: () => [
        isA<LoadingState>(),
        GetMandateStatusLoaded(
            getMandateStatusEntities: GetMandateStatusResponse.tResponse)
      ],
      verify: (_) {
        verify(mockGetMandateStatusUseCase(GetMandateStatusParams.tParams));
      },
    );

    blocTest(
      'when GetMandateStatusUseCase emits the ErrorState when error',
      build: () => mandateStatusCubit,
      setUp: () => when(mockGetMandateStatusUseCase(any)).thenAnswer(
          (realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.getMandateStatus(),
      expect: () => [
        isA<LoadingState>(),
        ErrorState(failure: ServerFailure.tServerFailure)
      ],
      verify: (_) {
        verify(mockGetMandateStatusUseCase(GetMandateStatusParams.tParams));
      },
    );
  });
  group("deleteMandate", () {
    blocTest(
      'when DeleteMandateUseCase emits the DeleteMandateLoaded when success',
      build: () => mandateStatusCubit,
      setUp: () => when(mockDeleteMandateUseCase(any)).thenAnswer(
          (realInvocation) async =>
              Right(AppSuccess(message: "Successfully done"))),
      act: (bloc) async =>
          await bloc.deleteMandate(DeleteMandateParams.tParams),
      expect: () => [
        isA<LoadingState>(),
        SuccessState(appSuccess: AppSuccess.tAppSuccess)
      ],
      verify: (_) {
        verify(mockDeleteMandateUseCase(DeleteMandateParams.tParams));
      },
    );

    blocTest(
      'when DeleteMandateUseCase emits the ErrorState when error',
      build: () => mandateStatusCubit,
      setUp: () => when(mockDeleteMandateUseCase(any)).thenAnswer(
          (realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async =>
          await bloc.deleteMandate(DeleteMandateParams.tParams),
      expect: () => [
        isA<LoadingState>(),
        ErrorState(failure: ServerFailure.tServerFailure)
      ],
      verify: (_) {
        verify(mockDeleteMandateUseCase(DeleteMandateParams.tParams));
      },
    );
  });
}
