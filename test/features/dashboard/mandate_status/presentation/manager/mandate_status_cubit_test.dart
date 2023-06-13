    import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/dashboard/mandate_status/data/models/get_mandate_status_params.dart';
import 'package:wmd/features/dashboard/mandate_status/data/models/get_mandate_status_response.dart';
import 'package:wmd/features/dashboard/mandate_status/domain/use_cases/get_mandate_status_usecase.dart';
import 'package:wmd/features/dashboard/mandate_status/presentation/manager/mandate_status_cubit.dart';

import 'mandate_status_cubit_test.mocks.dart';



@GenerateMocks([
  GetMandateStatusUseCase,

])
void main() {
  late MockGetMandateStatusUseCase mockGetMandateStatusUseCase;

  late MandateStatusCubit mandateStatusCubit;


  setUp(() {
    mockGetMandateStatusUseCase = MockGetMandateStatusUseCase();

    mandateStatusCubit = MandateStatusCubit(
    mockGetMandateStatusUseCase,

    );
  });
  

  group("getMandateStatus", () {
    blocTest(
      'when GetMandateStatusUseCase emits the GetMandateStatusLoaded when success',
      build: () => mandateStatusCubit,
      setUp: () => when(mockGetMandateStatusUseCase(any))
          .thenAnswer((realInvocation) async => Right(GetMandateStatusResponse.tResponse)),
      act: (bloc) async => await bloc.getMandateStatus(),
      expect: () =>
      [isA<LoadingState>(), GetMandateStatusLoaded(getMandateStatusEntities : GetMandateStatusResponse.tResponse)],
      verify: (_) {
        verify(mockGetMandateStatusUseCase(GetMandateStatusParams.tParams));
      },
    );

    blocTest(
      'when GetMandateStatusUseCase emits the ErrorState when error',
      build: () => mandateStatusCubit,
      setUp: () => when(mockGetMandateStatusUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.getMandateStatus(),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockGetMandateStatusUseCase(GetMandateStatusParams.tParams));
      },
    );
  });

}

    