import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/assets_overview/portfolio_tab2/data/models/get_portfolio_tab_params.dart';
import 'package:wmd/features/assets_overview/portfolio_tab2/data/models/get_portfolio_tab_response.dart';
import 'package:wmd/features/assets_overview/portfolio_tab2/domain/use_cases/get_portfolio_tab_usecase.dart';


import '../../../../../core/util/local_storage_test.mocks.dart';
import '../../data/repositories/portfolio_tab2_repository_impl_test.mocks.dart';




void main() {
  late GetPortfolioTabUseCase getPortfolioTabUseCase;
  late MockPortfolioTab2Repository mockPortfolioTab2Repository;
  late MockLocalStorage mockLocalStorage;

  setUp(() {
    mockPortfolioTab2Repository = MockPortfolioTab2Repository();
    mockLocalStorage = MockLocalStorage();
    getPortfolioTabUseCase = GetPortfolioTabUseCase(mockPortfolioTab2Repository,mockLocalStorage);
  });

  test('should get GetPortfolioTabEntity from the repository', () async {
    //arrange
    when(mockPortfolioTab2Repository.getPortfolioTab(any))
        .thenAnswer((_) async => Right(GetPortfolioTabResponse.tResponse));
    when(mockLocalStorage.getOwnerId())
        .thenAnswer((realInvocation) => "ownerId");
    // act
    final result = await getPortfolioTabUseCase(GetPortfolioTabParams.tParams.portfolioId);

    // assert
    expect(result, equals(Right(GetPortfolioTabResponse.tResponse)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockPortfolioTab2Repository.getPortfolioTab(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      when(mockLocalStorage.getOwnerId())
          .thenAnswer((realInvocation) => "ownerId");
      //act
      final result = await getPortfolioTabUseCase(GetPortfolioTabParams.tParams.portfolioId);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockPortfolioTab2Repository.getPortfolioTab(GetPortfolioTabParams.tParams));
    },
  );
}

    