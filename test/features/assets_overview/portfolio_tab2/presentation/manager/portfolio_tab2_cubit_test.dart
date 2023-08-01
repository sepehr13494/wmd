    import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/assets_overview/portfolio_tab2/data/models/get_portfolio_allocation_response.dart';
import 'package:wmd/features/assets_overview/portfolio_tab2/data/models/get_portfolio_tab_params.dart';
import 'package:wmd/features/assets_overview/portfolio_tab2/data/models/get_portfolio_tab_response.dart';
import 'package:wmd/features/assets_overview/portfolio_tab2/domain/use_cases/get_portfolio_allocation_usecase.dart';
import 'package:wmd/features/assets_overview/portfolio_tab2/domain/use_cases/get_portfolio_tab_usecase.dart';
import 'package:wmd/features/assets_overview/portfolio_tab2/presentation/manager/portfolio_tab2_cubit.dart';

import 'portfolio_tab2_cubit_test.mocks.dart';



@GenerateMocks([
  GetPortfolioAllocationUseCase,
  GetPortfolioTabUseCase,

])
void main() {
  late MockGetPortfolioAllocationUseCase mockGetPortfolioAllocationUseCase;
  late MockGetPortfolioTabUseCase mockGetPortfolioTabUseCase;

  late PortfolioTab2Cubit portfolioTab2Cubit;


  setUp(() {
    mockGetPortfolioAllocationUseCase = MockGetPortfolioAllocationUseCase();
    mockGetPortfolioTabUseCase = MockGetPortfolioTabUseCase();

    portfolioTab2Cubit = PortfolioTab2Cubit(
    mockGetPortfolioAllocationUseCase,
    mockGetPortfolioTabUseCase,

    );
  });
  

  group("getPortfolioAllocation", () {
    blocTest(
      'when GetPortfolioAllocationUseCase emits the GetPortfolioAllocationLoaded when success',
      build: () => portfolioTab2Cubit,
      setUp: () => when(mockGetPortfolioAllocationUseCase())
          .thenAnswer((realInvocation) async => Right(GetPortfolioAllocationResponse.tResponse)),
      act: (bloc) async => await bloc.getPortfolioAllocation(),
      expect: () =>
      [isA<LoadingState>(), GetPortfolioAllocationLoaded(getPortfolioAllocationEntities : GetPortfolioAllocationResponse.tResponse)],
      verify: (_) {
        verify(mockGetPortfolioAllocationUseCase());
      },
    );

    blocTest(
      'when GetPortfolioAllocationUseCase emits the ErrorState when error',
      build: () => portfolioTab2Cubit,
      setUp: () => when(mockGetPortfolioAllocationUseCase())
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.getPortfolioAllocation(),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockGetPortfolioAllocationUseCase());
      },
    );
  });
  group("getPortfolioTab", () {
    blocTest(
      'when GetPortfolioTabUseCase emits the GetPortfolioTabLoaded when success',
      build: () => portfolioTab2Cubit,
      setUp: () => when(mockGetPortfolioTabUseCase(any))
          .thenAnswer((realInvocation) async => Right(GetPortfolioTabResponse.tResponse)),
      act: (bloc) async => await bloc.getPortfolioTab(portfolioId: GetPortfolioTabParams.tParams.portfolioId),
      expect: () =>
      [isA<LoadingState>(), GetPortfolioTabLoaded(getPortfolioTabEntity : GetPortfolioTabResponse.tResponse)],
      verify: (_) {
        verify(mockGetPortfolioTabUseCase(GetPortfolioTabParams.tParams.portfolioId));
      },
    );

    blocTest(
      'when GetPortfolioTabUseCase emits the ErrorState when error',
      build: () => portfolioTab2Cubit,
      setUp: () => when(mockGetPortfolioTabUseCase(any))
          .thenAnswer((realInvocation) async => const Left(ServerFailure.tServerFailure)),
      act: (bloc) async => await bloc.getPortfolioTab(portfolioId: GetPortfolioTabParams.tParams.portfolioId),
      expect: () =>
      [isA<LoadingState>(), ErrorState(failure: ServerFailure.tServerFailure)],
      verify: (_) {
        verify(mockGetPortfolioTabUseCase(GetPortfolioTabParams.tParams.portfolioId));
      },
    );
  });

}

    