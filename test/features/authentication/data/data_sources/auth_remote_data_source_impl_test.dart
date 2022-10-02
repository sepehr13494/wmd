import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:wmd/features/authentication/data/models/login_response_model.dart';
import 'package:wmd/features/authentication/data/models/register_response_model.dart';
import 'package:wmd/features/authentication/domain/use_cases/post_login_usecase.dart';
import 'package:wmd/features/authentication/domain/use_cases/post_register_usecase.dart';

import '../../../../core/data/network/error_handler_middleware_test.mocks.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;
  setUp(() async {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    authRemoteDataSourceImpl =
        AuthRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('login function', () {
    final jsonMap = jsonDecode(fixture('login_success_response.json'));
    final tLoginParams = const LoginParams(email: 'test@yopmail.com', password: 'Passw0rd');
    final tLoginResponse = LoginResponse.fromJson(jsonMap);
    final tRequestOptions = AppRequestOptions(
      RequestTypes.post,
      "https://tfo.mocklab.io/login",
      tLoginParams.toJson(),
    );
    test('should return LoginResponse when API call is successful', () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenAnswer((_) async => await jsonMap);
      //act
      final result = await authRemoteDataSourceImpl.login(tLoginParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tRequestOptions));
      expect(result, tLoginResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      final tServerException = ServerException(message: 'exception message');
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(tServerException);
      //act
      // final result = await authRemoteDataSourceImpl.login(tLoginParams);
      final call = authRemoteDataSourceImpl.login;
      //assert
      expect(
          () => call(tLoginParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.message, 'message', tServerException.message)));
      verify(mockErrorHandlerMiddleware.sendRequest(tRequestOptions));
    });
  });

  group('register function', () {
    final Map<String, dynamic> jsonMap = {};
    final tRegisterParams = const RegisterParams(email: 'test@yopmail.com', password: 'Passw0rd');
    final tRegisterResponse = RegisterResponse.fromJson(jsonMap);
    final tRequestOptions = AppRequestOptions(
      RequestTypes.post,
      "https://tfo.mocklab.io/register",
      tRegisterParams.toJson(),
    );
    test('should return RegisterResponse when API call is successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenAnswer((_) async => await jsonMap);
      //act
      final result = await authRemoteDataSourceImpl.register(tRegisterParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tRequestOptions));
      expect(result, tRegisterResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      final tServerException = ServerException(message: 'exception message');
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(tServerException);
      //act
      // final result = await authRemoteDataSourceImpl.login(tRegisterParams);
      final call = authRemoteDataSourceImpl.register;
      //assert
      expect(
          () => call(tRegisterParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.message, 'message', tServerException.message)));
      verify(mockErrorHandlerMiddleware.sendRequest(tRequestOptions));
    });
  });
}
