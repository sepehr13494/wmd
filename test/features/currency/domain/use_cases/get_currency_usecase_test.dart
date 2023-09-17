import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/currency/data/models/get_currency_params.dart';
import 'package:wmd/features/currency/data/models/get_currency_response.dart';

import '../../data/repositories/currency_repository_impl_test.mocks.dart';
import '../../presentation/manager/currency_cubit_test.mocks.dart';

void main() {
  late MockGetCurrencyConversionUseCase getCurrencyUseCase;
  late MockCurrencyRepository mockCurrencyRepository;

  setUp(() {
    mockCurrencyRepository = MockCurrencyRepository();
    getCurrencyUseCase = MockGetCurrencyConversionUseCase();
  });

  test('should get GetCurrencyEntity from the repository', () async {
    //arrange
    when(mockCurrencyRepository.getCurrency(any)).thenAnswer(
        (_) async => Right(GetCurrencyConversionResponse.tResponse));
    // act
    final result =
        await getCurrencyUseCase(GetCurrencyConversionParams.tParams);

    // assert
    expect(result, equals(Right(GetCurrencyConversionResponse.tResponse)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockCurrencyRepository.getCurrency(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result =
          await getCurrencyUseCase(GetCurrencyConversionParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockCurrencyRepository
          .getCurrency(GetCurrencyConversionParams.tParams));
    },
  );
}
