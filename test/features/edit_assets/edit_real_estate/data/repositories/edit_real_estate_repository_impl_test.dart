import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/data/data_sources/edit_real_estate_remote_datasource.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/data/models/delete_real_estate_params.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/data/models/delete_real_estate_response.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/data/models/put_real_estate_params.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/data/models/put_real_estate_response.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/data/repositories/edit_real_estate_repository_impl.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/domain/repositories/edit_real_estate_repository.dart';

import 'edit_real_estate_repository_impl_test.mocks.dart';


@GenerateMocks([EditRealEstateRemoteDataSource,EditRealEstateRepository])
void main() {
  late MockEditRealEstateRemoteDataSource remoteDataSource;
  late EditRealEstateRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockEditRealEstateRemoteDataSource();
    repositoryImpl = EditRealEstateRepositoryImpl(
        remoteDataSource);
  });

  group('PutRealEstate', () {
    test(
      'should return PutRealEstateResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.putRealEstate(any))
            .thenAnswer((_) async => PutRealEstateResponse.tResponse);
        // act
        final result = await repositoryImpl.putRealEstate(PutRealEstateParams.tParams);
        // assert
        expect(result, equals(const Right(AppSuccess.tAppSuccess)));
        verify(remoteDataSource.putRealEstate(PutRealEstateParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.putRealEstate(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.putRealEstate(PutRealEstateParams.tParams);
        // assert
        verify(remoteDataSource.putRealEstate(PutRealEstateParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.putRealEstate(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.putRealEstate(PutRealEstateParams.tParams);
        // assert
        verify(remoteDataSource.putRealEstate(PutRealEstateParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });
  group('DeleteRealEstate', () {
    test(
      'should return DeleteRealEstateResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.deleteRealEstate(any))
            .thenAnswer((_) async => DeleteRealEstateResponse.tResponse);
        // act
        final result = await repositoryImpl.deleteRealEstate(DeleteRealEstateParams.tParams);
        // assert
        expect(result, equals(const Right(AppSuccess.tAppSuccess)));
        verify(remoteDataSource.deleteRealEstate(DeleteRealEstateParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.deleteRealEstate(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.deleteRealEstate(DeleteRealEstateParams.tParams);
        // assert
        verify(remoteDataSource.deleteRealEstate(DeleteRealEstateParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.deleteRealEstate(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.deleteRealEstate(DeleteRealEstateParams.tParams);
        // assert
        verify(remoteDataSource.deleteRealEstate(DeleteRealEstateParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });

}
