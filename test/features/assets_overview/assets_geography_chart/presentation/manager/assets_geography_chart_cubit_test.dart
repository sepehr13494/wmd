    import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/data/models/get_assets_geography_params.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/data/models/get_assets_geography_response.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/domain/use_cases/get_assets_geography_usecase.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/presentation/manager/assets_geography_chart_cubit.dart';

import 'assets_geography_chart_cubit_test.mocks.dart';



@GenerateMocks([
  GetAssetsGeographyUseCase,

])
void main() {
  late MockGetAssetsGeographyUseCase mockGetAssetsGeographyUseCase;

  late AssetsGeographyChartCubit assetsGeographyChartCubit;


  setUp(() {
    mockGetAssetsGeographyUseCase = MockGetAssetsGeographyUseCase();

    assetsGeographyChartCubit = AssetsGeographyChartCubit(
    mockGetAssetsGeographyUseCase,

    );
  });
  

  group("getAssetsGeography", () {
    blocTest(
      'when GetAssetsGeographyUseCase emits the GetAssetsGeographyLoaded when success',
      build: () => assetsGeographyChartCubit,
      setUp: () => when(mockGetAssetsGeographyUseCase(any))
          .thenAnswer((realInvocation) async => Right(GetAssetsGeographyResponse.tResponse)),
      act: (bloc) async => await bloc.getAssetsGeography(),
      expect: () =>
      [isA<LoadingState>(), GetAssetsGeographyLoaded(getAssetsGeographyEntities : GetAssetsGeographyResponse.tResponse)],
      verify: (_) {
        verify(mockGetAssetsGeographyUseCase(GetAssetsGeographyParams.tParams));
      },
    );

    blocTest(
      'when GetAssetsGeographyUseCase emits the ErrorState when error',
      build: () => assetsGeographyChartCubit,
      setUp: () => when(mockGetAssetsGeographyUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.getAssetsGeography(),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockGetAssetsGeographyUseCase(GetAssetsGeographyParams.tParams));
      },
    );
  });

}

    