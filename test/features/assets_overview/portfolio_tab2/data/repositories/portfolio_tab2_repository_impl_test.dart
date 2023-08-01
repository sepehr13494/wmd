import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/assets_overview/portfolio_tab2/data/data_sources/portfolio_tab2_remote_datasource.dart';
import 'package:wmd/features/assets_overview/portfolio_tab2/data/models/get_portfolio_allocation_params.dart';
import 'package:wmd/features/assets_overview/portfolio_tab2/data/models/get_portfolio_allocation_response.dart';
import 'package:wmd/features/assets_overview/portfolio_tab2/data/models/get_portfolio_tab_params.dart';
import 'package:wmd/features/assets_overview/portfolio_tab2/data/models/get_portfolio_tab_response.dart';
import 'package:wmd/features/assets_overview/portfolio_tab2/data/repositories/portfolio_tab2_repository_impl.dart';
import 'package:wmd/features/assets_overview/portfolio_tab2/domain/repositories/portfolio_tab2_repository.dart';

import 'portfolio_tab2_repository_impl_test.mocks.dart';


@GenerateMocks([PortfolioTab2RemoteDataSource,PortfolioTab2Repository])
void main() {
  late MockPortfolioTab2RemoteDataSource remoteDataSource;
  late PortfolioTab2RepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockPortfolioTab2RemoteDataSource();
    repositoryImpl = PortfolioTab2RepositoryImpl(
        remoteDataSource);
  });

  group('GetPortfolioAllocation', () {
    test(
      'should return GetPortfolioAllocationResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.getPortfolioAllocation(any))
            .thenAnswer((_) async => GetPortfolioAllocationResponse.tResponse);
        // act
        final result = await repositoryImpl.getPortfolioAllocation(GetPortfolioAllocationParams.tParams);
        // assert
        expect(result, equals(Right(GetPortfolioAllocationResponse.tResponse)));
        verify(remoteDataSource.getPortfolioAllocation(GetPortfolioAllocationParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.getPortfolioAllocation(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.getPortfolioAllocation(GetPortfolioAllocationParams.tParams);
        // assert
        verify(remoteDataSource.getPortfolioAllocation(GetPortfolioAllocationParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.getPortfolioAllocation(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.getPortfolioAllocation(GetPortfolioAllocationParams.tParams);
        // assert
        verify(remoteDataSource.getPortfolioAllocation(GetPortfolioAllocationParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
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
