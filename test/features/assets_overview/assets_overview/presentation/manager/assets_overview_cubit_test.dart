import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/assets_overview/assets_overview/data/models/assets_overview_params.dart';
import 'package:wmd/features/assets_overview/assets_overview/data/models/assets_overview_response.dart';
import 'package:wmd/features/assets_overview/assets_overview/domain/use_cases/get_assets_overview_usecase.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/manager/assets_overview_cubit.dart';

import 'assets_overview_cubit_test.mocks.dart';



@GenerateMocks([
  GetAssetsOverviewUseCase

])
void main() {
  late MockGetAssetsOverviewUseCase mockGetAssetsOverviewUseCase;
  late AssetsOverviewCubit assetsOverviewCubit;


  setUp(() {
    mockGetAssetsOverviewUseCase = MockGetAssetsOverviewUseCase();
    assetsOverviewCubit =
        AssetsOverviewCubit(mockGetAssetsOverviewUseCase);
  });


  group("getAssetsOverview", () {
    blocTest(
      'when GetAssetsOverviewUseCase is emits the AssetsOverviewLoaded when success',
      build: () => assetsOverviewCubit,
      setUp: () => when(mockGetAssetsOverviewUseCase(any))
          .thenAnswer((realInvocation) async => Right(AssetsOverviewResponse.tAssetsOverviewList)),
      act: (bloc) async => await bloc.getAssetsOverview(),
      expect: () =>
      [isA<LoadingState>(), AssetsOverviewLoaded(assetsOverviews: AssetsOverviewResponse.tAssetsOverviewList)],
      verify: (_) {
        verify(mockGetAssetsOverviewUseCase(AssetsOverviewParams.tParams));
      },
    );


    blocTest(
      'when GetAssetsOverviewUseCase is emits the ErrorState when error',
      build: () => assetsOverviewCubit,
      setUp: () => when(mockGetAssetsOverviewUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.getAssetsOverview(),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockGetAssetsOverviewUseCase(AssetsOverviewParams.tParams));
      },
    );
  });
}
