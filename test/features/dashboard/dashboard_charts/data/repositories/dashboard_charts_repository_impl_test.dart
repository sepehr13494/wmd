import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/assets_overview/assets_overview/data/models/assets_overview_params.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/data_sources/dashboard_charts_remote_datasource.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/models/get_allocation_params.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/models/get_allocation_response.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/models/get_geographic_params.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/models/get_geographic_response.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/models/get_pie_params.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/models/get_pie_response.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/repositories/dashboard_charts_repository_impl.dart';
import 'package:wmd/features/dashboard/dashboard_charts/domain/repositories/dashboard_charts_repository.dart';

import 'dashboard_charts_repository_impl_test.mocks.dart';


@GenerateMocks([DashboardChartsRemoteDataSource,DashboardChartsRepository])
void main() {
  late MockDashboardChartsRemoteDataSource remoteDataSource;
  late DashboardChartsRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockDashboardChartsRemoteDataSource();
    repositoryImpl = DashboardChartsRepositoryImpl(
        remoteDataSource);
  });

  group('GetAllocation', () {
    test(
      'should return GetAllocationResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.getAllocation(any))
            .thenAnswer((_) async => GetAllocationResponse.tResponse);
        // act
        final result = await repositoryImpl.getAllocation(GetAllocationParams.tParams);
        // assert
        expect(result, equals(const Right(GetAllocationResponse.tResponse)));
        verify(remoteDataSource.getAllocation(GetAllocationParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.getAllocation(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.getAllocation(GetAllocationParams.tParams);
        // assert
        verify(remoteDataSource.getAllocation(GetAllocationParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
  });
  group('GetGeographic', () {
    test(
      'should return GetGeographicResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.getGeographic(any))
            .thenAnswer((_) async => GetGeographicResponse.tResponse);
        // act
        final result = await repositoryImpl.getGeographic(GetGeographicParams.tParams);
        // assert
        expect(result, equals(Right(GetGeographicResponse.tResponse)));
        verify(remoteDataSource.getGeographic(GetGeographicParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.getGeographic(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.getGeographic(GetGeographicParams.tParams);
        // assert
        verify(remoteDataSource.getGeographic(GetGeographicParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
  });
  group('GetPie', () {
    test(
      'should return GetPieResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.getPie(any))
            .thenAnswer((_) async => GetPieResponse.tResponse);
        // act
        final result = await repositoryImpl.getPie(GetPieParams.tParams);
        // assert
        expect(result, equals(Right(GetPieResponse.tResponse)));
        verify(remoteDataSource.getPie(GetPieParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.getPie(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.getPie(GetPieParams.tParams);
        // assert
        verify(remoteDataSource.getPie(GetPieParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
  });

}
