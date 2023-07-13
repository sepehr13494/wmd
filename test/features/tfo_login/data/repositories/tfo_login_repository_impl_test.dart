import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/add_assets/tfo_login/data/data_sources/tfo_login_remote_datasource.dart';
import 'package:wmd/features/add_assets/tfo_login/data/models/get_mandates_params.dart';
import 'package:wmd/features/add_assets/tfo_login/data/models/get_mandates_response.dart';
import 'package:wmd/features/add_assets/tfo_login/data/models/login_tfo_account_params.dart';
import 'package:wmd/features/add_assets/tfo_login/data/models/login_tfo_account_response.dart';
import 'package:wmd/features/add_assets/tfo_login/data/repositories/tfo_login_repository_impl.dart';
import 'package:wmd/features/add_assets/tfo_login/domain/repositories/tfo_login_repository.dart';

import 'tfo_login_repository_impl_test.mocks.dart';

@GenerateMocks([TfoLoginRemoteDataSource, TfoLoginRepository])
void main() {
  late MockTfoLoginRemoteDataSource remoteDataSource;
  late TfoLoginRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockTfoLoginRemoteDataSource();
    repositoryImpl = TfoLoginRepositoryImpl(remoteDataSource);
  });

  group('GetMandates', () {
    test(
      'should return GetMandatesResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.getMandates(any))
            .thenAnswer((_) async => GetMandatesResponse.tResponse);
        // act
        final result =
            await repositoryImpl.getMandates(GetMandatesParams.tParams);
        // assert
        expect(result, equals(Right(AppSuccess.tAppSuccess)));
        verify(remoteDataSource.getMandates(GetMandatesParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.getMandates(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result =
            await repositoryImpl.getMandates(GetMandatesParams.tParams);
        // assert
        verify(remoteDataSource.getMandates(GetMandatesParams.tParams));

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
        when(remoteDataSource.getMandates(any))
            .thenThrow(AppException.tAppException);
        // act
        final result =
            await repositoryImpl.getMandates(GetMandatesParams.tParams);
        // assert
        verify(remoteDataSource.getMandates(GetMandatesParams.tParams));

        expect(
            result,
            equals(
                Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
  });
  group('LoginTfoAccount', () {
    test(
      'should return LoginTfoAccountResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.loginTfoAccount(any))
            .thenAnswer((_) async => LoginTfoAccountResponse.tResponse);
        // act
        final result =
            await repositoryImpl.loginTfoAccount(LoginTfoAccountParams.tParams);
        // assert
        expect(result, equals(Right(AppSuccess.tAppSuccess)));
        verify(remoteDataSource.loginTfoAccount(LoginTfoAccountParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.loginTfoAccount(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result =
            await repositoryImpl.loginTfoAccount(LoginTfoAccountParams.tParams);
        // assert
        verify(remoteDataSource.loginTfoAccount(LoginTfoAccountParams.tParams));

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
        when(remoteDataSource.loginTfoAccount(any))
            .thenThrow(AppException.tAppException);
        // act
        final result =
            await repositoryImpl.loginTfoAccount(LoginTfoAccountParams.tParams);
        // assert
        verify(remoteDataSource.loginTfoAccount(LoginTfoAccountParams.tParams));

        expect(
            result,
            equals(
                Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
  });
}
