import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_benchmark_params.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_benchmark_response.dart';
import 'package:wmd/features/dashboard/performance_table/domain/use_cases/get_benchmark_usecase.dart';


import '../../data/repositories/performance_table_repository_impl_test.mocks.dart';




void main() {
  late GetBenchmarkUseCase getBenchmarkUseCase;
  late MockPerformanceTableRepository mockPerformanceTableRepository;

  setUp(() {
    mockPerformanceTableRepository = MockPerformanceTableRepository();
    getBenchmarkUseCase = GetBenchmarkUseCase(mockPerformanceTableRepository);
  });

  test('should get GetBenchmarkEntity from the repository', () async {
    //arrange
    when(mockPerformanceTableRepository.getBenchmark(any))
        .thenAnswer((_) async => Right(GetBenchmarkResponse.tResponse));
    // act
    final result = await getBenchmarkUseCase(GetBenchmarkParams.tParams);

    // assert
    expect(result, equals(Right(GetBenchmarkResponse.tResponse)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockPerformanceTableRepository.getBenchmark(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await getBenchmarkUseCase(GetBenchmarkParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockPerformanceTableRepository.getBenchmark(GetBenchmarkParams.tParams));
    },
  );
}

    