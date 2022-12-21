import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/profile/profile_reset_password/data/data_sources/profile_reset_password_remote_datasource.dart';
import 'package:wmd/features/profile/profile_reset_password/data/models/reset_params.dart';
import 'package:wmd/features/profile/profile_reset_password/data/models/reset_response.dart';
import 'package:wmd/features/profile/profile_reset_password/data/repositories/profile_reset_password_repository_impl.dart';
import 'package:wmd/features/profile/profile_reset_password/domain/repositories/profile_reset_password_repository.dart';

import 'profile_reset_password_repository_impl_test.mocks.dart';


@GenerateMocks([ProfileResetPasswordRemoteDataSource,ProfileResetPasswordRepository])
void main() {
  late MockProfileResetPasswordRemoteDataSource remoteDataSource;
  late ProfileResetPasswordRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockProfileResetPasswordRemoteDataSource();
    repositoryImpl = ProfileResetPasswordRepositoryImpl(
        remoteDataSource);
  });

  group('Reset', () {
    test(
      'should return ResetResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.reset(any))
            .thenAnswer((_) async => ResetResponse.tResponse);
        // act
        final result = await repositoryImpl.reset(ResetParams.tParams);
        // assert
        expect(result, equals(Right(AppSuccess.tAppSuccess)));
        verify(remoteDataSource.reset(ResetParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.reset(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.reset(ResetParams.tParams);
        // assert
        verify(remoteDataSource.reset(ResetParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.reset(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.reset(ResetParams.tParams);
        // assert
        verify(remoteDataSource.reset(ResetParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });

}
