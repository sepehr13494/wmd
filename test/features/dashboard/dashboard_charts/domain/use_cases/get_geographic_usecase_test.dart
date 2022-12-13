import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/models/get_geographic_params.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/models/get_geographic_response.dart';
import 'package:wmd/features/dashboard/dashboard_charts/domain/use_cases/get_geographic_usecase.dart';

import '../../../../../core/util/local_storage_test.mocks.dart';
import '../../data/repositories/dashboard_charts_repository_impl_test.mocks.dart';




void main() {
  late GetGeographicUseCase getGeographicUseCase;
  late MockDashboardChartsRepository mockDashboardChartsRepository;
  late MockLocalStorage mockLocalStorage;

  setUp(() {
    mockDashboardChartsRepository = MockDashboardChartsRepository();
    mockLocalStorage = MockLocalStorage();
    getGeographicUseCase = GetGeographicUseCase(mockDashboardChartsRepository,mockLocalStorage);
  });

  test('should get GetGeographicEntity from the repository', () async {
    //arrange
    when(mockDashboardChartsRepository.getGeographic(any))
        .thenAnswer((_) async => Right(GetGeographicResponse.tResponse));
    when(mockLocalStorage.getOwnerId())
        .thenAnswer((_) => "testId");
    // act
    final result = await getGeographicUseCase(NoParams());

    // assert
    expect(result, equals(Right(GetGeographicResponse.tResponse)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockDashboardChartsRepository.getGeographic(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      when(mockLocalStorage.getOwnerId())
          .thenAnswer((_) => "testId");
      //act
      final result = await getGeographicUseCase(NoParams());
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockDashboardChartsRepository.getGeographic(GetGeographicParams.tParams));
    },
  );
}

    