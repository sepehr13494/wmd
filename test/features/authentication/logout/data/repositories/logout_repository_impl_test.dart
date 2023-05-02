import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/authentication/logout/data/data_sources/logout_remote_datasource.dart';
import 'package:wmd/features/authentication/logout/data/models/perform_logout_params.dart';
import 'package:wmd/features/authentication/logout/data/models/perform_logout_response.dart';
import 'package:wmd/features/authentication/logout/data/repositories/logout_repository_impl.dart';
import 'package:wmd/features/authentication/logout/domain/repositories/logout_repository.dart';

import 'logout_repository_impl_test.mocks.dart';


@GenerateMocks([LogoutRemoteDataSource,LogoutRepository])
void main() {
  late MockLogoutRemoteDataSource remoteDataSource;
  late LogoutRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockLogoutRemoteDataSource();
    repositoryImpl = LogoutRepositoryImpl(
        remoteDataSource);
  });

  group('PerformLogout', () {
    test(
      'should return PerformLogoutResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.performLogout(any))
            .thenAnswer((_) async => PerformLogoutResponse.tResponse);
        // act
        final result = await repositoryImpl.performLogout(PerformLogoutParams.tParams);
        // assert
        expect(result, equals(Right(AppSuccess.tAppSuccess)));
        verify(remoteDataSource.performLogout(PerformLogoutParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.performLogout(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.performLogout(PerformLogoutParams.tParams);
        // assert
        verify(remoteDataSource.performLogout(PerformLogoutParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.performLogout(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.performLogout(PerformLogoutParams.tParams);
        // assert
        verify(remoteDataSource.performLogout(PerformLogoutParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });

}
