import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_custodian_performance_params.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_custodian_performance_response.dart';
import 'package:wmd/features/dashboard/performance_table/domain/use_cases/get_custodian_performance_usecase.dart';


import '../../data/repositories/performance_table_repository_impl_test.mocks.dart';




void main() {
  late GetCustodianPerformanceUseCase getCustodianPerformanceUseCase;
  late MockPerformanceTableRepository mockPerformanceTableRepository;

  setUp(() {
    mockPerformanceTableRepository = MockPerformanceTableRepository();
    getCustodianPerformanceUseCase = GetCustodianPerformanceUseCase(mockPerformanceTableRepository);
  });

  test('should get GetCustodianPerformanceEntity from the repository', () async {
    //arrange
    when(mockPerformanceTableRepository.getCustodianPerformance(any))
        .thenAnswer((_) async => Right(GetCustodianPerformanceResponse.tResponse));
    // act
    final result = await getCustodianPerformanceUseCase(GetCustodianPerformanceParams.tParams);

    // assert
    expect(result, equals(Right(GetCustodianPerformanceResponse.tResponse)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockPerformanceTableRepository.getCustodianPerformance(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await getCustodianPerformanceUseCase(GetCustodianPerformanceParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockPerformanceTableRepository.getCustodianPerformance(GetCustodianPerformanceParams.tParams));
    },
  );
}

    