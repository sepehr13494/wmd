import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_asset_class_params.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_asset_class_response.dart';
import 'package:wmd/features/dashboard/performance_table/domain/use_cases/get_asset_class_usecase.dart';


import '../../data/repositories/performance_table_repository_impl_test.mocks.dart';




void main() {
  late GetAssetClassUseCase getAssetClassUseCase;
  late MockPerformanceTableRepository mockPerformanceTableRepository;

  setUp(() {
    mockPerformanceTableRepository = MockPerformanceTableRepository();
    getAssetClassUseCase = GetAssetClassUseCase(mockPerformanceTableRepository);
  });

  test('should get GetAssetClassEntity from the repository', () async {
    //arrange
    when(mockPerformanceTableRepository.getAssetClass(any))
        .thenAnswer((_) async => Right(GetAssetClassResponse.tResponse));
    // act
    final result = await getAssetClassUseCase(GetAssetClassParams.tParams);

    // assert
    expect(result, equals(Right(GetAssetClassResponse.tResponse)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockPerformanceTableRepository.getAssetClass(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await getAssetClassUseCase(GetAssetClassParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockPerformanceTableRepository.getAssetClass(GetAssetClassParams.tParams));
    },
  );
}

    