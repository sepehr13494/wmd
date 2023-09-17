import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/currency/data/models/get_currency_params.dart';
import 'package:wmd/features/currency/data/models/get_currency_response.dart';
import 'package:wmd/features/currency/domain/use_cases/get_currency_usecase.dart';
import 'package:wmd/features/currency/presentation/manager/currency_cubit.dart';

import 'currency_cubit_test.mocks.dart';

@GenerateMocks([
  GetCurrencyConversionUseCase,
])
void main() {
  late MockGetCurrencyConversionUseCase mockGetCurrencyUseCase;

  late CurrencyCubit currencyCubit;

  setUp(() {
    mockGetCurrencyUseCase = MockGetCurrencyConversionUseCase();

    currencyCubit = CurrencyCubit(
      mockGetCurrencyUseCase,
    );
  });

  group("getCurrency", () {
    blocTest(
      'when GetCurrencyUseCase emits the GetCurrencyLoaded when success',
      build: () => currencyCubit,
      setUp: () => when(mockGetCurrencyUseCase(any)).thenAnswer(
          (realInvocation) async =>
              Right(GetCurrencyConversionResponse.tResponse)),
      act: (bloc) async => await bloc.getCurrency("INR", "USD"),
      expect: () => [
        isA<LoadingState>(),
        GetCurrencyConversionLoaded(
            getCurrencyEntity: GetCurrencyConversionResponse.tResponse)
      ],
      verify: (_) {
        verify(mockGetCurrencyUseCase(GetCurrencyConversionParams.tParams));
      },
    );

    blocTest(
      'when GetCurrencyUseCase emits the ErrorState when error',
      build: () => currencyCubit,
      setUp: () => when(mockGetCurrencyUseCase(any)).thenAnswer(
          (realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.getCurrency("INR", "USD"),
      expect: () => [
        isA<LoadingState>(),
        ErrorState(failure: ServerFailure.tServerFailure)
      ],
      verify: (_) {
        verify(mockGetCurrencyUseCase(GetCurrencyConversionParams.tParams));
      },
    );
  });
}
