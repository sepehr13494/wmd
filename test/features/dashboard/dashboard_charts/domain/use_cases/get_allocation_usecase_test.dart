import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/models/get_allocation_params.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/models/get_allocation_response.dart';
import 'package:wmd/features/dashboard/dashboard_charts/domain/use_cases/get_allocation_usecase.dart';

import '../../../../../core/util/local_storage_test.mocks.dart';
import '../../data/repositories/dashboard_charts_repository_impl_test.mocks.dart';


void main() {
  late GetAllocationUseCase getAllocationUseCase;
  late MockDashboardChartsRepository mockDashboardChartsRepository;
  late MockLocalStorage mockLocalStorage;

  setUp(() {
    mockDashboardChartsRepository = MockDashboardChartsRepository();
    mockLocalStorage = MockLocalStorage();
    getAllocationUseCase = GetAllocationUseCase(mockDashboardChartsRepository,mockLocalStorage);
  });

  test('should get GetAllocationEntity from the repository', () async {
    //arrange
    when(mockDashboardChartsRepository.getAllocation(any))
        .thenAnswer((_) async => const Right(GetAllocationResponse.tResponse));
    when(mockLocalStorage.getOwnerId())
        .thenAnswer((_) => "testId");
    // act
    final result = await getAllocationUseCase(CustomizableDateTime.currentDateTime);

    // assert
    expect(result, equals(const Right(GetAllocationResponse.tResponse)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockDashboardChartsRepository.getAllocation(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      when(mockLocalStorage.getOwnerId())
          .thenAnswer((_) => "testId");
      //act
      final result = await getAllocationUseCase(CustomizableDateTime.currentDateTime);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockDashboardChartsRepository.getAllocation(GetAllocationParams.tParams));
    },
  );
}

    