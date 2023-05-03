import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/dashboard/performance_table/client_index/data/models/get_client_index_params.dart';
import 'package:wmd/features/dashboard/performance_table/client_index/data/models/get_client_index_response.dart';
import 'package:wmd/features/dashboard/performance_table/client_index/domain/use_cases/get_client_index_usecase.dart';
import 'package:wmd/features/dashboard/performance_table/client_index/presentation/manager/client_index_cubit.dart';

import 'client_index_cubit_test.mocks.dart';



@GenerateMocks([
  GetClientIndexUseCase,

])
void main() {
  late MockGetClientIndexUseCase mockGetClientIndexUseCase;

  late ClientIndexCubit clientIndexCubit;


  setUp(() {
    mockGetClientIndexUseCase = MockGetClientIndexUseCase();

    clientIndexCubit = ClientIndexCubit(
      mockGetClientIndexUseCase,

    );
  });


  group("getClientIndex", () {
    blocTest(
      'when GetClientIndexUseCase emits the GetClientIndexLoaded when success',
      build: () => clientIndexCubit,
      setUp: () => when(mockGetClientIndexUseCase(any))
          .thenAnswer((realInvocation) async => Right(GetClientIndexResponse.tResponse)),
      act: (bloc) async => await bloc.getClientIndex(),
      expect: () =>
      [isA<LoadingState>(), GetClientIndexLoaded(getClientIndexEntity : GetClientIndexResponse.tResponse)],
      verify: (_) {
        verify(mockGetClientIndexUseCase(GetClientIndexParams.tParams));
      },
    );

    blocTest(
      'when GetClientIndexUseCase emits the ErrorState when error',
      build: () => clientIndexCubit,
      setUp: () => when(mockGetClientIndexUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.getClientIndex(),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockGetClientIndexUseCase(GetClientIndexParams.tParams));
      },
    );
  });

}

    