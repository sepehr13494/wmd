import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/assets_overview/portfolio_tab/data/data_sources/portfolio_tab_remote_datasource.dart';
import 'package:wmd/features/assets_overview/portfolio_tab/data/models/get_portfolio_tab_params.dart';
import 'package:wmd/features/assets_overview/portfolio_tab/data/models/get_portfolio_tab_response.dart';
import 'package:wmd/features/assets_overview/portfolio_tab/data/repositories/portfolio_tab_repository_impl.dart';
import 'package:wmd/features/assets_overview/portfolio_tab/domain/repositories/portfolio_tab_repository.dart';

import 'portfolio_tab_repository_impl_test.mocks.dart';


@GenerateMocks([PortfolioTabRemoteDataSource,PortfolioTabRepository])
void main() {
  late MockPortfolioTabRemoteDataSource remoteDataSource;
  late PortfolioTabRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockPortfolioTabRemoteDataSource();
    repositoryImpl = PortfolioTabRepositoryImpl(
        remoteDataSource);
  });

  group('GetPortfolioTab', () {
    test(
      'should return GetPortfolioTabResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.getPortfolioTab(any))
            .thenAnswer((_) async => GetPortfolioTabResponse.tResponse);
        // act
        final result = await repositoryImpl.getPortfolioTab(GetPortfolioTabParams.tParams);
        // assert
        expect(result, equals(Right(GetPortfolioTabResponse.tResponse)));
        verify(remoteDataSource.getPortfolioTab(GetPortfolioTabParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.getPortfolioTab(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.getPortfolioTab(GetPortfolioTabParams.tParams);
        // assert
        verify(remoteDataSource.getPortfolioTab(GetPortfolioTabParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.getPortfolioTab(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.getPortfolioTab(GetPortfolioTabParams.tParams);
        // assert
        verify(remoteDataSource.getPortfolioTab(GetPortfolioTabParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });

}
