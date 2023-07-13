    import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/assets_overview/portfolio_tab/data/models/get_portfolio_tab_params.dart';
import 'package:wmd/features/assets_overview/portfolio_tab/data/models/get_portfolio_tab_response.dart';
import 'package:wmd/features/assets_overview/portfolio_tab/domain/use_cases/get_portfolio_tab_usecase.dart';
import 'package:wmd/features/assets_overview/portfolio_tab/presentation/manager/portfolio_tab_cubit.dart';

import 'portfolio_tab_cubit_test.mocks.dart';



@GenerateMocks([
  GetPortfolioTabUseCase,

])
void main() {
  late MockGetPortfolioTabUseCase mockGetPortfolioTabUseCase;

  late PortfolioTabCubit portfolioTabCubit;


  setUp(() {
    mockGetPortfolioTabUseCase = MockGetPortfolioTabUseCase();

    portfolioTabCubit = PortfolioTabCubit(
    mockGetPortfolioTabUseCase,

    );
  });
  

  group("getPortfolioTab", () {
    blocTest(
      'when GetPortfolioTabUseCase emits the GetPortfolioTabLoaded when success',
      build: () => portfolioTabCubit,
      setUp: () => when(mockGetPortfolioTabUseCase(any))
          .thenAnswer((realInvocation) async => Right(GetPortfolioTabResponse.tResponse)),
      act: (bloc) async => await bloc.getPortfolioTab(),
      expect: () =>
      [isA<LoadingState>(), GetPortfolioTabLoaded(getPortfolioTabEntities : GetPortfolioTabResponse.tResponse)],
      verify: (_) {
        verify(mockGetPortfolioTabUseCase(GetPortfolioTabParams.tParams));
      },
    );

    blocTest(
      'when GetPortfolioTabUseCase emits the ErrorState when error',
      build: () => portfolioTabCubit,
      setUp: () => when(mockGetPortfolioTabUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.getPortfolioTab(),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockGetPortfolioTabUseCase(GetPortfolioTabParams.tParams));
      },
    );
  });

}

    