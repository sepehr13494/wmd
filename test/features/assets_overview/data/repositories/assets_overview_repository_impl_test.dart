import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/assets_overview/assets_overview/data/data_sources/asset_overview_remote_datasource.dart';
import 'package:wmd/features/assets_overview/assets_overview/data/models/assets_overview_params.dart';
import 'package:wmd/features/assets_overview/assets_overview/data/models/assets_overview_response.dart';
import 'package:wmd/features/assets_overview/assets_overview/data/repositories/assets_overview_repository_impl.dart';
import 'package:wmd/features/assets_overview/assets_overview/domain/repositories/assets_overview_repository.dart';

import 'assets_overview_repository_impl_test.mocks.dart';


@GenerateMocks([AssetsOverviewRemoteDataSource,AssetsOverviewRepository])
void main() {
  late MockAssetsOverviewRemoteDataSource remoteDataSource;
  late AssetsOverviewRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockAssetsOverviewRemoteDataSource();
    repositoryImpl = AssetsOverviewRepositoryImpl(
        remoteDataSource);
  });

  group('test for getAssetsOverview in AssetsOverviewRepository', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.getAssetsOverview(any))
            .thenAnswer((_) async => AssetsOverviewResponse.tAssetsOverviewList);
        // act
        final result = await repositoryImpl.getAssetsOverview(AssetsOverviewParams.tParams);
        // assert
        expect(result, equals(Right(AssetsOverviewResponse.tAssetsOverviewList)));
        verify(remoteDataSource.getAssetsOverview(AssetsOverviewParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.getAssetsOverview(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.getAssetsOverview(AssetsOverviewParams.tParams);
        // assert
        verify(remoteDataSource.getAssetsOverview(AssetsOverviewParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
  });
}
