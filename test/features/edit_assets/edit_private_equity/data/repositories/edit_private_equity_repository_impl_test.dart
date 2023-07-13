import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/data/data_sources/edit_private_equity_remote_datasource.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/data/models/delete_private_equity_params.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/data/models/delete_private_equity_response.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/data/models/put_private_equity_params.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/data/models/put_private_equity_response.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/data/repositories/edit_private_equity_repository_impl.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/domain/repositories/edit_private_equity_repository.dart';

import 'edit_private_equity_repository_impl_test.mocks.dart';


@GenerateMocks([EditPrivateEquityRemoteDataSource,EditPrivateEquityRepository])
void main() {
  late MockEditPrivateEquityRemoteDataSource remoteDataSource;
  late EditPrivateEquityRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockEditPrivateEquityRemoteDataSource();
    repositoryImpl = EditPrivateEquityRepositoryImpl(
        remoteDataSource);
  });

  group('PutPrivateEquity', () {
    test(
      'should return PutPrivateEquityResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.putPrivateEquity(any))
            .thenAnswer((_) async => PutPrivateEquityResponse.tResponse);
        // act
        final result = await repositoryImpl.putPrivateEquity(PutPrivateEquityParams.tParams);
        // assert
        expect(result, equals(Right(AppSuccess.tAppSuccess)));
        verify(remoteDataSource.putPrivateEquity(PutPrivateEquityParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.putPrivateEquity(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.putPrivateEquity(PutPrivateEquityParams.tParams);
        // assert
        verify(remoteDataSource.putPrivateEquity(PutPrivateEquityParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.putPrivateEquity(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.putPrivateEquity(PutPrivateEquityParams.tParams);
        // assert
        verify(remoteDataSource.putPrivateEquity(PutPrivateEquityParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });
  group('DeletePrivateEquity', () {
    test(
      'should return DeletePrivateEquityResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.deletePrivateEquity(any))
            .thenAnswer((_) async => DeletePrivateEquityResponse.tResponse);
        // act
        final result = await repositoryImpl.deletePrivateEquity(DeletePrivateEquityParams.tParams);
        // assert
        expect(result, equals(Right(AppSuccess.tAppSuccess)));
        verify(remoteDataSource.deletePrivateEquity(DeletePrivateEquityParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.deletePrivateEquity(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.deletePrivateEquity(DeletePrivateEquityParams.tParams);
        // assert
        verify(remoteDataSource.deletePrivateEquity(DeletePrivateEquityParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.deletePrivateEquity(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.deletePrivateEquity(DeletePrivateEquityParams.tParams);
        // assert
        verify(remoteDataSource.deletePrivateEquity(DeletePrivateEquityParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });

}
