import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/liability_overview/data/data_sources/liablility_overview_remote_datasource.dart';
import 'package:wmd/features/liability_overview/data/models/get_liablility_overview_params.dart';
import 'package:wmd/features/liability_overview/data/models/get_liablility_overview_response.dart';
import 'package:wmd/features/liability_overview/data/repositories/liablility_overview_repository_impl.dart';
import 'package:wmd/features/liability_overview/domain/repositories/liablility_overview_repository.dart';

import 'liability_overview_repository_impl_test.mocks.dart';

@GenerateMocks([LiabilityOverviewRemoteDataSource, LiabilityOverviewRepository])
void main() {
  late MockLiabilityOverviewRemoteDataSource remoteDataSource;
  late LiabilityOverviewRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockLiabilityOverviewRemoteDataSource();
    repositoryImpl = LiabilityOverviewRepositoryImpl(remoteDataSource);
  });

  group('GetLiabilityOverview', () {
    test(
      'should return GetLiabilityOverviewResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.getLiablilityOverview(any))
            .thenAnswer((_) async => GetLiabilityOverviewResponse.tResponse);
        // act
        final result = await repositoryImpl
            .getLiablilityOverview(GetLiabilityOverviewParams.tParams);
        // assert
        expect(result, equals(Right(GetLiabilityOverviewResponse.tResponse)));
        verify(remoteDataSource
            .getLiablilityOverview(GetLiabilityOverviewParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.getLiablilityOverview(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl
            .getLiablilityOverview(GetLiabilityOverviewParams.tParams);
        // assert
        verify(remoteDataSource
            .getLiablilityOverview(GetLiabilityOverviewParams.tParams));

        expect(
            result,
            equals(Left(ServerFailure.fromServerException(
                ServerException.tServerException))));
      },
    );

    test(
      'should return app failure on app exception',
      () async {
        // arrange
        when(remoteDataSource.getLiablilityOverview(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl
            .getLiablilityOverview(GetLiabilityOverviewParams.tParams);
        // assert
        verify(remoteDataSource
            .getLiablilityOverview(GetLiabilityOverviewParams.tParams));

        expect(
            result,
            equals(
                Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
  });
}
