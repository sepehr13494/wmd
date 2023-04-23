import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/data/data_sources/edit_private_debt_remote_datasource.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/data/models/delete_private_debt_params.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/data/models/delete_private_debt_response.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/data/models/put_private_debt_params.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/data/models/put_private_debt_response.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/data/repositories/edit_private_debt_repository_impl.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/domain/repositories/edit_private_debt_repository.dart';

import 'edit_private_debt_repository_impl_test.mocks.dart';


@GenerateMocks([EditPrivateDebtRemoteDataSource,EditPrivateDebtRepository])
void main() {
  late MockEditPrivateDebtRemoteDataSource remoteDataSource;
  late EditPrivateDebtRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockEditPrivateDebtRemoteDataSource();
    repositoryImpl = EditPrivateDebtRepositoryImpl(
        remoteDataSource);
  });

  group('PutPrivateDebt', () {
    test(
      'should return PutPrivateDebtResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.putPrivateDebt(any))
            .thenAnswer((_) async => PutPrivateDebtResponse.tResponse);
        // act
        final result = await repositoryImpl.putPrivateDebt(PutPrivateDebtParams.tParams);
        // assert
        expect(result, equals(Right(AppSuccess.tAppSuccess)));
        verify(remoteDataSource.putPrivateDebt(PutPrivateDebtParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.putPrivateDebt(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.putPrivateDebt(PutPrivateDebtParams.tParams);
        // assert
        verify(remoteDataSource.putPrivateDebt(PutPrivateDebtParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.putPrivateDebt(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.putPrivateDebt(PutPrivateDebtParams.tParams);
        // assert
        verify(remoteDataSource.putPrivateDebt(PutPrivateDebtParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });
  group('DeletePrivateDebt', () {
    test(
      'should return DeletePrivateDebtResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.deletePrivateDebt(any))
            .thenAnswer((_) async => DeletePrivateDebtResponse.tResponse);
        // act
        final result = await repositoryImpl.deletePrivateDebt(DeletePrivateDebtParams.tParams);
        // assert
        expect(result, equals(Right(AppSuccess.tAppSuccess)));
        verify(remoteDataSource.deletePrivateDebt(DeletePrivateDebtParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.deletePrivateDebt(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.deletePrivateDebt(DeletePrivateDebtParams.tParams);
        // assert
        verify(remoteDataSource.deletePrivateDebt(DeletePrivateDebtParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.deletePrivateDebt(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.deletePrivateDebt(DeletePrivateDebtParams.tParams);
        // assert
        verify(remoteDataSource.deletePrivateDebt(DeletePrivateDebtParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });

}
