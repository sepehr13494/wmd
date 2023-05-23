import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/liability_overview/data/models/get_liablility_overview_params.dart';
import 'package:wmd/features/liability_overview/data/models/get_liablility_overview_response.dart';
import 'package:wmd/features/liability_overview/domain/use_cases/get_liablility_overview_usecase.dart';
import 'package:wmd/features/liability_overview/presentation/manager/liablility_overview_cubit.dart';

import 'liability_overview_cubit_test.mocks.dart';

@GenerateMocks([
  GetLiabilityOverviewUseCase,
])
void main() {
  late MockGetLiabilityOverviewUseCase mockGetLiablilityOverviewUseCase;

  late LiabilityOverviewCubit liablilityOverviewCubit;

  setUp(() {
    mockGetLiablilityOverviewUseCase = MockGetLiabilityOverviewUseCase();

    liablilityOverviewCubit = LiabilityOverviewCubit(
      mockGetLiablilityOverviewUseCase,
    );
  });

  group("getLiablilityOverview", () {
    blocTest(
      'when GetLiablilityOverviewUseCase emits the GetLiablilityOverviewLoaded when success',
      build: () => liablilityOverviewCubit,
      setUp: () => when(mockGetLiablilityOverviewUseCase(any)).thenAnswer(
          (realInvocation) async =>
              Right(GetLiabilityOverviewResponse.tResponse)),
      act: (bloc) async => await bloc.getLiablilityOverview(),
      expect: () => [
        isA<LoadingState>(),
        GetLiabilityOverviewLoaded(
            getLiablilityOverviewEntities:
                GetLiabilityOverviewResponse.tResponse)
      ],
      verify: (_) {
        verify(mockGetLiablilityOverviewUseCase(
            GetLiabilityOverviewParams.tParams));
      },
    );

    blocTest(
      'when GetLiabilityOverviewUseCase emits the ErrorState when error',
      build: () => liablilityOverviewCubit,
      setUp: () => when(mockGetLiablilityOverviewUseCase(any)).thenAnswer(
          (realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.getLiablilityOverview(),
      expect: () => [
        isA<LoadingState>(),
        ErrorState(failure: ServerFailure.tServerFailure)
      ],
      verify: (_) {
        verify(mockGetLiablilityOverviewUseCase(
            GetLiabilityOverviewParams.tParams));
      },
    );
  });
}
