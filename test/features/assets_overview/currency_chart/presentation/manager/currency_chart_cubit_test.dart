    import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/assets_overview/currency_chart/data/models/get_currency_params.dart';
import 'package:wmd/features/assets_overview/currency_chart/data/models/get_currency_response.dart';
import 'package:wmd/features/assets_overview/currency_chart/domain/use_cases/get_currency_usecase.dart';
import 'package:wmd/features/assets_overview/currency_chart/presentation/manager/currency_chart_cubit.dart';

import 'currency_chart_cubit_test.mocks.dart';



@GenerateMocks([
  GetCurrencyUseCase,

])
void main() {
  late MockGetCurrencyUseCase mockGetCurrencyUseCase;

  late CurrencyChartCubit currencyChartCubit;


  setUp(() {
    mockGetCurrencyUseCase = MockGetCurrencyUseCase();

    currencyChartCubit = CurrencyChartCubit(
    mockGetCurrencyUseCase,

    );
  });
  

  group("getCurrency", () {
    blocTest(
      'when GetCurrencyUseCase emits the GetCurrencyLoaded when success',
      build: () => currencyChartCubit,
      setUp: () => when(mockGetCurrencyUseCase(any))
          .thenAnswer((realInvocation) async => Right(GetCurrencyResponse.tResponse)),
      act: (bloc) async => await bloc.getCurrency(),
      expect: () =>
      [isA<LoadingState>(), GetCurrencyLoaded(getCurrencyEntities : GetCurrencyResponse.tResponse)],
      verify: (_) {
        verify(mockGetCurrencyUseCase(NoParams()));
      },
    );

    blocTest(
      'when GetCurrencyUseCase emits the ErrorState when error',
      build: () => currencyChartCubit,
      setUp: () => when(mockGetCurrencyUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.getCurrency(),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockGetCurrencyUseCase(NoParams()));
      },
    );
  });

}

    