import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/data/models/get_assets_geography_params.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/data/models/get_assets_geography_response.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/domain/use_cases/get_assets_geography_usecase.dart';


import '../../data/repositories/assets_geography_chart_repository_impl_test.mocks.dart';




void main() {
  late GetAssetsGeographyUseCase getAssetsGeographyUseCase;
  late MockAssetsGeographyChartRepository mockAssetsGeographyChartRepository;

  setUp(() {
    mockAssetsGeographyChartRepository = MockAssetsGeographyChartRepository();
    getAssetsGeographyUseCase = GetAssetsGeographyUseCase(mockAssetsGeographyChartRepository);
  });

  test('should get GetAssetsGeographyEntity from the repository', () async {
    //arrange
    when(mockAssetsGeographyChartRepository.getAssetsGeography(any))
        .thenAnswer((_) async => Right(GetAssetsGeographyResponse.tResponse));
    // act
    final result = await getAssetsGeographyUseCase(GetAssetsGeographyParams.tParams);

    // assert
    expect(result, equals(Right(GetAssetsGeographyResponse.tResponse)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockAssetsGeographyChartRepository.getAssetsGeography(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await getAssetsGeographyUseCase(GetAssetsGeographyParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockAssetsGeographyChartRepository.getAssetsGeography(GetAssetsGeographyParams.tParams));
    },
  );
}

    