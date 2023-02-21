import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/data/data_sources/assets_geography_chart_remote_datasource.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/data/models/get_assets_geography_params.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/data/models/get_assets_geography_response.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/data/repositories/assets_geography_chart_repository_impl.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/domain/repositories/assets_geography_chart_repository.dart';

import 'assets_geography_chart_repository_impl_test.mocks.dart';


@GenerateMocks([AssetsGeographyChartRemoteDataSource,AssetsGeographyChartRepository])
void main() {
  late MockAssetsGeographyChartRemoteDataSource remoteDataSource;
  late AssetsGeographyChartRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockAssetsGeographyChartRemoteDataSource();
    repositoryImpl = AssetsGeographyChartRepositoryImpl(
        remoteDataSource);
  });

  group('GetAssetsGeography', () {
    test(
      'should return GetAssetsGeographyResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.getAssetsGeography(any))
            .thenAnswer((_) async => GetAssetsGeographyResponse.tResponse);
        // act
        final result = await repositoryImpl.getAssetsGeography(GetAssetsGeographyParams.tParams);
        // assert
        expect(result, equals(Right(GetAssetsGeographyResponse.tResponse)));
        verify(remoteDataSource.getAssetsGeography(GetAssetsGeographyParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.getAssetsGeography(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.getAssetsGeography(GetAssetsGeographyParams.tParams);
        // assert
        verify(remoteDataSource.getAssetsGeography(GetAssetsGeographyParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.getAssetsGeography(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.getAssetsGeography(GetAssetsGeographyParams.tParams);
        // assert
        verify(remoteDataSource.getAssetsGeography(GetAssetsGeographyParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });

}
