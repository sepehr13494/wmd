import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:wmd/features/authentication/data/models/login_response_model.dart';
import 'package:wmd/features/authentication/data/models/register_response_model.dart';
import 'package:wmd/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:wmd/features/authentication/domain/use_cases/post_login_usecase.dart';
import 'package:wmd/features/authentication/domain/use_cases/post_register_usecase.dart';

import '../../../splash/data/repositories/splash_repository_impl_test.mocks.dart';
import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource])
void main() {
  late AuthRepositoryImpl authRepositoryImpl;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late MockLocalStorage mockLocalStorage;

  setUp(() async {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalStorage = MockLocalStorage();
    authRepositoryImpl = AuthRepositoryImpl(
      mockLocalStorage,
      mockAuthRemoteDataSource,
    );
  });

  const tLoginParams =
      LoginParams(username: 'test@yopmail.com', password: 'Passw0rd');

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
        when(mockAuthRemoteDataSource.login(any))
            .thenAnswer((_) async => tLoginResponse);
        when(mockLocalStorage.setTokenAndLogin(any))
            .thenAnswer((_) async => await null);
        when(mockLocalStorage.setRefreshToken(any))
            .thenAnswer((_) async => await null);
        // act
        final result = await authRepositoryImpl.login(tLoginParams);
        // assert
        verify(mockAuthRemoteDataSource.login(tLoginParams));
        verify(mockLocalStorage.setTokenAndLogin(tLoginResponse.accessToken));
        verify(mockLocalStorage.setRefreshToken(tLoginResponse.refreshToken));
        expect(result, equals(const Right(tAppSuccess)));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(mockAuthRemoteDataSource.login(any)).thenThrow(tServerException);
        // act
        final result = await authRepositoryImpl.login(tLoginParams);
        // assert
        verify(mockAuthRemoteDataSource.login(tLoginParams));

        expect(result,
            equals(Left(ServerFailure(message: tServerException.message))));
      },
    );

    test(
      'should return cache failure on cache exception',
      () async {
        // arrange
        when(mockAuthRemoteDataSource.login(any))
            .thenAnswer((_) async => tLoginResponse);
        when(mockLocalStorage.setTokenAndLogin(any)).thenThrow(tCacheException);
        // act
        final result = await authRepositoryImpl.login(tLoginParams);
        // assert
        verify(mockAuthRemoteDataSource.login(tLoginParams));

        expect(result,
            equals(Left(CacheFailure(message: tCacheException.message))));
      },
    );
  });

  group('register functions in auth repository', () {
    final tRegisterResponse = RegisterResponse();
    final tRegisterParams =
        RegisterParams(email: 'test@yopmail.com', password: 'Passw0rd');
    const tAppRegisterSuccess = AppSuccess(message: 'Register successful');
    test(
      'should return remote data when the call to auth remote data source is successful',
      () async {
        // arrange
        when(mockAuthRemoteDataSource.register(any))
            .thenAnswer((_) async => tRegisterResponse);
        // act
        final result = await authRepositoryImpl.register(tRegisterParams);
        // assert
        verify(mockAuthRemoteDataSource.register(tRegisterParams));
        expect(result, equals(const Right(tAppRegisterSuccess)));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(mockAuthRemoteDataSource.register(any))
            .thenThrow(tServerException);
        // act
        final result = await authRepositoryImpl.register(tRegisterParams);
        // assert
        verify(mockAuthRemoteDataSource.register(tRegisterParams));

        expect(result,
            equals(Left(ServerFailure(message: tServerException.message))));
      },
    );
  });
}
