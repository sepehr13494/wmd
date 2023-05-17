import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/data/data_sources/edit_other_assets_remote_datasource.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/data/models/delete_other_assets_params.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/data/models/delete_other_assets_response.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/data/models/put_other_assets_params.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/data/models/put_other_assets_response.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/data/repositories/edit_other_assets_repository_impl.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/domain/repositories/edit_other_assets_repository.dart';

import 'edit_other_assets_repository_impl_test.mocks.dart';


@GenerateMocks([EditOtherAssetsRemoteDataSource,EditOtherAssetsRepository])
void main() {
  late MockEditOtherAssetsRemoteDataSource remoteDataSource;
  late EditOtherAssetsRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockEditOtherAssetsRemoteDataSource();
    repositoryImpl = EditOtherAssetsRepositoryImpl(
        remoteDataSource);
  });

  group('PutOtherAssets', () {
    test(
      'should return PutOtherAssetsResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.putOtherAssets(any))
            .thenAnswer((_) async => PutOtherAssetsResponse.tResponse);
        // act
        final result = await repositoryImpl.putOtherAssets(PutOtherAssetsParams.tParams);
        // assert
        expect(result, equals(Right(AppSuccess.tAppSuccess)));
        verify(remoteDataSource.putOtherAssets(PutOtherAssetsParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.putOtherAssets(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.putOtherAssets(PutOtherAssetsParams.tParams);
        // assert
        verify(remoteDataSource.putOtherAssets(PutOtherAssetsParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.putOtherAssets(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.putOtherAssets(PutOtherAssetsParams.tParams);
        // assert
        verify(remoteDataSource.putOtherAssets(PutOtherAssetsParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });
  group('DeleteOtherAssets', () {
    test(
      'should return DeleteOtherAssetsResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.deleteOtherAssets(any))
            .thenAnswer((_) async => DeleteOtherAssetsResponse.tResponse);
        // act
        final result = await repositoryImpl.deleteOtherAssets(DeleteOtherAssetsParams.tParams);
        // assert
        expect(result, equals(Right(AppSuccess.tAppSuccess)));
        verify(remoteDataSource.deleteOtherAssets(DeleteOtherAssetsParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.deleteOtherAssets(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.deleteOtherAssets(DeleteOtherAssetsParams.tParams);
        // assert
        verify(remoteDataSource.deleteOtherAssets(DeleteOtherAssetsParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.deleteOtherAssets(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.deleteOtherAssets(DeleteOtherAssetsParams.tParams);
        // assert
        verify(remoteDataSource.deleteOtherAssets(DeleteOtherAssetsParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });

}
