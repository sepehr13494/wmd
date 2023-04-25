import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/data/data_sources/edit_listed_asset_remote_datasource.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/data/models/delete_listed_asset_params.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/data/models/delete_listed_asset_response.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/data/models/put_listed_asset_params.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/data/models/put_listed_asset_response.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/data/repositories/edit_listed_asset_repository_impl.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/domain/repositories/edit_listed_asset_repository.dart';

import 'edit_listed_asset_repository_impl_test.mocks.dart';


@GenerateMocks([EditListedAssetRemoteDataSource,EditListedAssetRepository])
void main() {
  late MockEditListedAssetRemoteDataSource remoteDataSource;
  late EditListedAssetRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockEditListedAssetRemoteDataSource();
    repositoryImpl = EditListedAssetRepositoryImpl(
        remoteDataSource);
  });

  group('PutListedAsset', () {
    test(
      'should return PutListedAssetResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.putListedAsset(any))
            .thenAnswer((_) async => PutListedAssetResponse.tResponse);
        // act
        final result = await repositoryImpl.putListedAsset(PutListedAssetParams.tParams);
        // assert
        expect(result, equals(Right(AppSuccess.tAppSuccess)));
        verify(remoteDataSource.putListedAsset(PutListedAssetParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.putListedAsset(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.putListedAsset(PutListedAssetParams.tParams);
        // assert
        verify(remoteDataSource.putListedAsset(PutListedAssetParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.putListedAsset(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.putListedAsset(PutListedAssetParams.tParams);
        // assert
        verify(remoteDataSource.putListedAsset(PutListedAssetParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });
  group('DeleteListedAsset', () {
    test(
      'should return DeleteListedAssetResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.deleteListedAsset(any))
            .thenAnswer((_) async => DeleteListedAssetResponse.tResponse);
        // act
        final result = await repositoryImpl.deleteListedAsset(DeleteListedAssetParams.tParams);
        // assert
        expect(result, equals(Right(AppSuccess.tAppSuccess)));
        verify(remoteDataSource.deleteListedAsset(DeleteListedAssetParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.deleteListedAsset(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.deleteListedAsset(DeleteListedAssetParams.tParams);
        // assert
        verify(remoteDataSource.deleteListedAsset(DeleteListedAssetParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.deleteListedAsset(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.deleteListedAsset(DeleteListedAssetParams.tParams);
        // assert
        verify(remoteDataSource.deleteListedAsset(DeleteListedAssetParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });

}
