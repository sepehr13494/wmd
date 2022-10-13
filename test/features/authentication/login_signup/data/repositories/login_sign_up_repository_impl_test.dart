import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/authentication/login_signup/data/data_sources/login_sign_up_remote_data_source.dart';
import 'package:wmd/features/authentication/login_signup/data/models/login_response_model.dart';
import 'package:wmd/features/authentication/login_signup/data/models/register_response_model.dart';
import 'package:wmd/features/authentication/login_signup/data/repositories/login_sign_up_repository_impl.dart';
import 'package:wmd/features/authentication/login_signup/domain/repositories/login_sign_up_repository.dart';
import 'package:wmd/features/authentication/login_signup/domain/use_cases/post_login_usecase.dart';
import 'package:wmd/features/authentication/login_signup/domain/use_cases/post_register_usecase.dart';
import 'package:wmd/features/authentication/login_signup/domain/use_cases/resend_email_usecase.dart';

import '../../../../../core/util/local_storage_test.mocks.dart';
import 'login_sign_up_repository_impl_test.mocks.dart';

@GenerateMocks([LoginSignUpRemoteDataSource,LoginSignUpRepository])
void main() {
  late LoginSignUpRepositoryImpl loginSignUpRepositoryImpl;
  late MockLoginSignUpRemoteDataSource mockLoginSignUpRemoteDataSource;
  late MockLocalStorage mockLocalStorage;

  setUp(() async {
    mockLoginSignUpRemoteDataSource = MockLoginSignUpRemoteDataSource();
    mockLocalStorage = MockLocalStorage();
    loginSignUpRepositoryImpl = LoginSignUpRepositoryImpl(
      mockLocalStorage,
      mockLoginSignUpRemoteDataSource,
    );
  });

  const tLoginParams = LoginParams(email: 'test@yopmail.com', password: 'Passw0rd');

  final tLoginResponse = LoginResponse(
    roles: ["role"],
    isSocial: false,
    idToken: "test idToken",
    expiresIn: 86400,
    refreshToken: "test refreshToken",
    accessToken: "test accessToken",
    tokenType: "Bearer",
  );

  const tAppSuccess = AppSuccess(message: 'Login successful');
  final tServerException = ServerException(message: 'test server message');
  final tCacheException = CacheException(message: 'test cache message');

  group('login functions in auth repository', () {
    test(
      'should return remote data when the call to auth remote data source is successful',
      () async {
        // arrange
        when(mockLoginSignUpRemoteDataSource.login(any))
            .thenAnswer((_) async => tLoginResponse);
        when(mockLocalStorage.setTokenAndLogin(any))
            .thenAnswer((_) async => await null);
        when(mockLocalStorage.setRefreshToken(any))
            .thenAnswer((_) async => await null);
        // act
        final result = await loginSignUpRepositoryImpl.login(tLoginParams);
        // assert
        verify(mockLoginSignUpRemoteDataSource.login(tLoginParams));
        verify(mockLocalStorage.setTokenAndLogin(tLoginResponse.accessToken));
        verify(mockLocalStorage.setRefreshToken(tLoginResponse.refreshToken));
        expect(result, equals(const Right(tAppSuccess)));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(mockLoginSignUpRemoteDataSource.login(any)).thenThrow(tServerException);
        // act
        final result = await loginSignUpRepositoryImpl.login(tLoginParams);
        // assert
        verify(mockLoginSignUpRemoteDataSource.login(tLoginParams));

        expect(result,
            equals(Left(ServerFailure(message: tServerException.message))));
      },
    );

    test(
      'should return cache failure on cache exception',
      () async {
        // arrange
        when(mockLoginSignUpRemoteDataSource.login(any))
            .thenAnswer((_) async => tLoginResponse);
        when(mockLocalStorage.setTokenAndLogin(any)).thenThrow(tCacheException);
        // act
        final result = await loginSignUpRepositoryImpl.login(tLoginParams);
        // assert
        verify(mockLoginSignUpRemoteDataSource.login(tLoginParams));

        expect(result,
            equals(Left(CacheFailure(message: tCacheException.message))));
      },
    );
  });

  group('register functions', () {
    final tRegisterResponse = RegisterResponse();
    final tRegisterParams =
        RegisterParams(email: 'test@yopmail.com', password: 'Passw0rd');
    const tAppRegisterSuccess = AppSuccess(message: 'Register successful');
    test(
      'should return AppSuccess when the call to auth remote data source is successful',
      () async {
        // arrange
        when(mockLoginSignUpRemoteDataSource.register(any))
            .thenAnswer((_) async => tRegisterResponse);
        // act
        final result = await loginSignUpRepositoryImpl.register(tRegisterParams);
        // assert
        verify(mockLoginSignUpRemoteDataSource.register(tRegisterParams));
        expect(result, equals(const Right(tAppRegisterSuccess)));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(mockLoginSignUpRemoteDataSource.register(any))
            .thenThrow(tServerException);
        // act
        final result = await loginSignUpRepositoryImpl.register(tRegisterParams);
        // assert
        verify(mockLoginSignUpRemoteDataSource.register(tRegisterParams));

        expect(result,
            equals(Left(ServerFailure(message: tServerException.message))));
      },
    );
  });

  group('resend email functions', () {
    const tResendEmailParams = ResendEmailParams.tResendEmailParams;
    const tSuccess = AppSuccess(message: 'Email sent successful');
    test(
      'should return AppSuccess when the call to login_sing_up_remote_data_source is successful',
          () async {
        // arrange
        // act
        final result = await loginSignUpRepositoryImpl.resendEmail(tResendEmailParams);
        // assert
        verify(mockLoginSignUpRemoteDataSource.resendEmail(tResendEmailParams));
        expect(result, equals(const Right(tSuccess)));
      },
    );

    test(
      'should return server failure on server exception',
          () async {
        // arrange
        when(mockLoginSignUpRemoteDataSource.resendEmail(any))
            .thenThrow(tServerException);
        // act
        final result = await loginSignUpRepositoryImpl.resendEmail(tResendEmailParams);
        // assert
        verify(mockLoginSignUpRemoteDataSource.resendEmail(tResendEmailParams));

        expect(result,
            equals(Left(ServerFailure(message: tServerException.message))));
      },
    );
  });
}
