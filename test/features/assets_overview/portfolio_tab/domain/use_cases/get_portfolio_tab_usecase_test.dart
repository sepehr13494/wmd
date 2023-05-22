import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/assets_overview/portfolio_tab/data/models/get_portfolio_tab_params.dart';
import 'package:wmd/features/assets_overview/portfolio_tab/data/models/get_portfolio_tab_response.dart';
import 'package:wmd/features/assets_overview/portfolio_tab/domain/use_cases/get_portfolio_tab_usecase.dart';


import '../../data/repositories/portfolio_tab_repository_impl_test.mocks.dart';




void main() {
  late GetPortfolioTabUseCase getPortfolioTabUseCase;
  late MockPortfolioTabRepository mockPortfolioTabRepository;

  setUp(() {
    mockPortfolioTabRepository = MockPortfolioTabRepository();
    getPortfolioTabUseCase = GetPortfolioTabUseCase(mockPortfolioTabRepository);
  });

  test('should get GetPortfolioTabEntity from the repository', () async {
    //arrange
    when(mockPortfolioTabRepository.getPortfolioTab(any))
        .thenAnswer((_) async => Right(GetPortfolioTabResponse.tResponse));
    // act
    final result = await getPortfolioTabUseCase(GetPortfolioTabParams.tParams);

    // assert
    expect(result, equals(Right(GetPortfolioTabResponse.tResponse)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockPortfolioTabRepository.getPortfolioTab(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await getPortfolioTabUseCase(GetPortfolioTabParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockPortfolioTabRepository.getPortfolioTab(GetPortfolioTabParams.tParams));
    },
  );
}

    