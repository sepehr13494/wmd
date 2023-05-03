import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/settings/linked_accounts/data/data_sources/linked_accounts_remote_datasource.dart';
import 'package:wmd/features/settings/linked_accounts/data/models/get_linked_accounts_params.dart';
import 'package:wmd/features/settings/linked_accounts/data/models/get_linked_accounts_response.dart';
import 'package:wmd/features/settings/linked_accounts/data/repositories/linked_accounts_repository_impl.dart';
import 'package:wmd/features/settings/linked_accounts/domain/repositories/linked_accounts_repository.dart';

import 'linked_accounts_repository_impl_test.mocks.dart';

@GenerateMocks([LinkedAccountsRemoteDataSource, LinkedAccountsRepository])
void main() {
  late MockLinkedAccountsRemoteDataSource remoteDataSource;
  late LinkedAccountsRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockLinkedAccountsRemoteDataSource();
    repositoryImpl = LinkedAccountsRepositoryImpl(remoteDataSource);
  });

  group('GetLinkedAccounts', () {
    test(
      'should return GetLinkedAccountsResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.getLinkedAccounts(any))
            .thenAnswer((_) async => GetLinkedAccountsResponse.tResponse);
        // act
        final result = await repositoryImpl
            .getLinkedAccounts(GetLinkedAccountsParams.tParams);
        // assert
        expect(result, equals(Right(GetLinkedAccountsResponse.tResponse)));
        verify(remoteDataSource
            .getLinkedAccounts(GetLinkedAccountsParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.getLinkedAccounts(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl
            .getLinkedAccounts(GetLinkedAccountsParams.tParams);
        // assert
        verify(remoteDataSource
            .getLinkedAccounts(GetLinkedAccountsParams.tParams));

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
        when(remoteDataSource.getLinkedAccounts(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl
            .getLinkedAccounts(GetLinkedAccountsParams.tParams);
        // assert
        verify(remoteDataSource
            .getLinkedAccounts(GetLinkedAccountsParams.tParams));

        expect(
            result,
            equals(
                Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
  });
}
