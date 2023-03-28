import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/dashboard/performance_table/data/data_sources/performance_table_remote_datasource.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_asset_class_params.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_asset_class_response.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_benchmark_params.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_benchmark_response.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_custodian_performance_params.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_custodian_performance_response.dart';
import 'package:wmd/features/dashboard/performance_table/data/repositories/performance_table_repository_impl.dart';
import 'package:wmd/features/dashboard/performance_table/domain/repositories/performance_table_repository.dart';

import 'performance_table_repository_impl_test.mocks.dart';


@GenerateMocks([PerformanceTableRemoteDataSource,PerformanceTableRepository])
void main() {
  late MockPerformanceTableRemoteDataSource remoteDataSource;
  late PerformanceTableRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockPerformanceTableRemoteDataSource();
    repositoryImpl = PerformanceTableRepositoryImpl(
        remoteDataSource);
  });

  group('GetAssetClass', () {
    test(
      'should return GetAssetClassResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.getAssetClass(any))
            .thenAnswer((_) async => GetAssetClassResponse.tResponse);
        // act
        final result = await repositoryImpl.getAssetClass(GetAssetClassParams.tParams);
        // assert
        expect(result, equals(Right(GetAssetClassResponse.tResponse)));
        verify(remoteDataSource.getAssetClass(GetAssetClassParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.getAssetClass(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.getAssetClass(GetAssetClassParams.tParams);
        // assert
        verify(remoteDataSource.getAssetClass(GetAssetClassParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.getAssetClass(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.getAssetClass(GetAssetClassParams.tParams);
        // assert
        verify(remoteDataSource.getAssetClass(GetAssetClassParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });
  group('GetBenchmark', () {
    test(
      'should return GetBenchmarkResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.getBenchmark(any))
            .thenAnswer((_) async => GetBenchmarkResponse.tResponse);
        // act
        final result = await repositoryImpl.getBenchmark(GetBenchmarkParams.tParams);
        // assert
        expect(result, equals(Right(GetBenchmarkResponse.tResponse)));
        verify(remoteDataSource.getBenchmark(GetBenchmarkParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.getBenchmark(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.getBenchmark(GetBenchmarkParams.tParams);
        // assert
        verify(remoteDataSource.getBenchmark(GetBenchmarkParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.getBenchmark(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.getBenchmark(GetBenchmarkParams.tParams);
        // assert
        verify(remoteDataSource.getBenchmark(GetBenchmarkParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });
  group('GetCustodianPerformance', () {
    test(
      'should return GetCustodianPerformanceResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.getCustodianPerformance(any))
            .thenAnswer((_) async => GetCustodianPerformanceResponse.tResponse);
        // act
        final result = await repositoryImpl.getCustodianPerformance(GetCustodianPerformanceParams.tParams);
        // assert
        expect(result, equals(Right(GetCustodianPerformanceResponse.tResponse)));
        verify(remoteDataSource.getCustodianPerformance(GetCustodianPerformanceParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.getCustodianPerformance(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.getCustodianPerformance(GetCustodianPerformanceParams.tParams);
        // assert
        verify(remoteDataSource.getCustodianPerformance(GetCustodianPerformanceParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.getCustodianPerformance(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.getCustodianPerformance(GetCustodianPerformanceParams.tParams);
        // assert
        verify(remoteDataSource.getCustodianPerformance(GetCustodianPerformanceParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });

}
