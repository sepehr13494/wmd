import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/data/data_sources/edit_bank_manual_remote_datasource.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/data/models/delete_bank_manual_params.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/data/models/delete_bank_manual_response.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/data/models/put_bank_manual_params.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/data/models/put_bank_manual_response.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/data/repositories/edit_bank_manual_repository_impl.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/domain/repositories/edit_bank_manual_repository.dart';

import 'edit_bank_manual_repository_impl_test.mocks.dart';


@GenerateMocks([EditBankManualRemoteDataSource,EditBankManualRepository])
void main() {
  late MockEditBankManualRemoteDataSource remoteDataSource;
  late EditBankManualRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockEditBankManualRemoteDataSource();
    repositoryImpl = EditBankManualRepositoryImpl(
        remoteDataSource);
  });

  group('PutBankManual', () {
    test(
      'should return PutBankManualResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.putBankManual(any))
            .thenAnswer((_) async => PutBankManualResponse.tResponse);
        // act
        final result = await repositoryImpl.putBankManual(PutBankManualParams.tParams);
        // assert
        expect(result, equals(const Right(AppSuccess.tAppSuccess)));
        verify(remoteDataSource.putBankManual(PutBankManualParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.putBankManual(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.putBankManual(PutBankManualParams.tParams);
        // assert
        verify(remoteDataSource.putBankManual(PutBankManualParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.putBankManual(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.putBankManual(PutBankManualParams.tParams);
        // assert
        verify(remoteDataSource.putBankManual(PutBankManualParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });
  group('DeleteBankManual', () {
    test(
      'should return DeleteBankManualResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.deleteBankManual(any))
            .thenAnswer((_) async => DeleteBankManualResponse.tResponse);
        // act
        final result = await repositoryImpl.deleteBankManual(DeleteBankManualParams.tParams);
        // assert
        expect(result, equals(const Right(AppSuccess.tAppSuccess)));
        verify(remoteDataSource.deleteBankManual(DeleteBankManualParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.deleteBankManual(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.deleteBankManual(DeleteBankManualParams.tParams);
        // assert
        verify(remoteDataSource.deleteBankManual(DeleteBankManualParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.deleteBankManual(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.deleteBankManual(DeleteBankManualParams.tParams);
        // assert
        verify(remoteDataSource.deleteBankManual(DeleteBankManualParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });

}
