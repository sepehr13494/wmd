import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/assets_overview/assets_overview/data/models/assets_overview_params.dart';
import 'package:wmd/features/assets_overview/assets_overview/data/models/assets_overview_response.dart';
import 'package:wmd/features/assets_overview/assets_overview/domain/entities/assets_overview_entity.dart';
import 'package:wmd/features/assets_overview/assets_overview/domain/use_cases/get_assets_overview_usecase.dart';

import '../../data/repositories/assets_overview_repository_impl_test.mocks.dart';




void main() {
  late GetAssetsOverviewUseCase getAssetsOverviewUsecase;
  late MockAssetsOverviewRepository mockAssetsOverviewRepository;

  setUp(() {
    mockAssetsOverviewRepository = MockAssetsOverviewRepository();
    getAssetsOverviewUsecase = GetAssetsOverviewUseCase(mockAssetsOverviewRepository);
  });

  test('should get user net worth from the repository', () async {
    //arrange
    when(mockAssetsOverviewRepository.getAssetsOverview(any))
        .thenAnswer((_) async => Right(AssetsOverviewResponse.tAssetsOverviewList));
    // act
    final result = await getAssetsOverviewUsecase(AssetsOverviewParams.tParams);

    // assert
    expect(result, equals(Right(AssetsOverviewResponse.tAssetsOverviewList)));
  });

  test(
    'should get Server Failure from the repository when server request fails',
    () async {
      const tServerFailure = ServerFailure(message: 'Server failure');
      //arrange
      when(mockAssetsOverviewRepository.getAssetsOverview(any))
          .thenAnswer((_) async => const Left(tServerFailure));
      //act
      final result = await getAssetsOverviewUsecase(AssetsOverviewParams.tParams);
      //assert
      expect(result, const Left(tServerFailure));
      verify(mockAssetsOverviewRepository.getAssetsOverview(AssetsOverviewParams.tParams));
    },
  );
}
