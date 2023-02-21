import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/features/assets_overview/currency_chart/data/models/get_currency_params.dart';
import 'package:wmd/features/assets_overview/currency_chart/data/models/get_currency_response.dart';
import 'package:wmd/features/assets_overview/currency_chart/domain/use_cases/get_currency_usecase.dart';


import '../../../../../core/util/local_storage_test.mocks.dart';
import '../../data/repositories/currency_chart_repository_impl_test.mocks.dart';




void main() {
  late GetCurrencyUseCase getCurrencyUseCase;
  late MockCurrencyChartRepository mockCurrencyChartRepository;
  late MockLocalStorage mockLocalStorage;

  setUp(() {
    mockCurrencyChartRepository = MockCurrencyChartRepository();
    mockLocalStorage = MockLocalStorage();
    getCurrencyUseCase = GetCurrencyUseCase(mockCurrencyChartRepository,mockLocalStorage);
  });

  test('should get GetCurrencyEntity from the repository', () async {
    //arrange
    when(mockCurrencyChartRepository.getCurrency(any))
        .thenAnswer((_) async => Right(GetCurrencyResponse.tResponse));
    // act
    final result = await getCurrencyUseCase(NoParams());

    // assert
    expect(result, equals(Right(GetCurrencyResponse.tResponse)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockCurrencyChartRepository.getCurrency(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await getCurrencyUseCase(NoParams());
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockCurrencyChartRepository.getCurrency(GetCurrencyParams.tParams));
    },
  );
}

    