import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/liability_overview/data/models/get_liablility_overview_params.dart';
import 'package:wmd/features/liability_overview/data/models/get_liablility_overview_response.dart';
import 'package:wmd/features/liability_overview/domain/use_cases/get_liablility_overview_usecase.dart';

import '../../data/repositories/liability_overview_repository_impl_test.mocks.dart';

void main() {
  late GetLiabilityOverviewUseCase getLiablilityOverviewUseCase;
  late MockLiabilityOverviewRepository mockLiablilityOverviewRepository;

  setUp(() {
    mockLiablilityOverviewRepository = MockLiabilityOverviewRepository();
    getLiablilityOverviewUseCase =
        GetLiabilityOverviewUseCase(mockLiablilityOverviewRepository);
  });

  test('should get GetLiablilityOverviewEntity from the repository', () async {
    //arrange
    when(mockLiablilityOverviewRepository.getLiablilityOverview(any))
        .thenAnswer((_) async => Right(GetLiabilityOverviewResponse.tResponse));
    // act
    final result =
        await getLiablilityOverviewUseCase(GetLiabilityOverviewParams.tParams);

    // assert
    expect(result, equals(Right(GetLiabilityOverviewResponse.tResponse)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockLiablilityOverviewRepository.getLiablilityOverview(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await getLiablilityOverviewUseCase(
          GetLiabilityOverviewParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockLiablilityOverviewRepository
          .getLiablilityOverview(GetLiabilityOverviewParams.tParams));
    },
  );
}
