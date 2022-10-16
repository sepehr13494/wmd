import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/authentication/login_signup/data/data_sources/login_sign_up_remote_data_source.dart';
import 'package:wmd/features/authentication/login_signup/data/models/login_response_model.dart';
import 'package:wmd/features/authentication/login_signup/data/models/register_response_model.dart';
import 'package:wmd/features/authentication/login_signup/domain/use_cases/post_login_usecase.dart';
import 'package:wmd/features/authentication/login_signup/domain/use_cases/post_register_usecase.dart';

import '../../../../../core/data/network/error_handler_middleware_test.mocks.dart';
import '../../../../../fixtures/fixture_reader.dart';

void main() {
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late LoginSignUpRemoteDataSourceImpl loginSignUpRemoteDataSourceImpl;
  setUp(() async {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    loginSignUpRemoteDataSourceImpl =
        LoginSignUpRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('login function', () {
    final jsonMap = jsonDecode(fixture('login_success_response.json'));
    const tLoginParams =
        LoginParams(username: 'test@yopmail.com', password: 'Passw0rd');
    final tLoginResponse = LoginResponse.fromJson(jsonMap);
    final tRequestOptions = AppRequestOptions(
      RequestTypes.post,
      AppUrls.loginUser,
      tLoginParams.toJson(),
    );
    test('should return LoginResponse when API call is successful', () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenAnswer((_) async => await jsonMap);
      //act
      final result = await loginSignUpRemoteDataSourceImpl.login(tLoginParams);
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
      // final result = await loginSignUpRemoteDataSourceImpl.login(tLoginParams);
      final call = loginSignUpRemoteDataSourceImpl.login;
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
    const tTermsOfService = TermsOfService(agreedAt: 'today');
    final tRegisterParams = RegisterParams(
        email: 'test@yopmail.com',
        password: 'Passw0rd',
        termsOfService: tTermsOfService);
    final tRegisterResponse = RegisterResponse.fromJson(jsonMap);
    final tRequestOptions = AppRequestOptions(
      RequestTypes.post,
      AppUrls.registerUser,
      tRegisterParams.toJson(),
    );
    test('should return RegisterResponse when API call is successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenAnswer((_) async => await jsonMap);
      //act
      final result =
          await loginSignUpRemoteDataSourceImpl.register(tRegisterParams);
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
      // final result = await loginSignUpRemoteDataSourceImpl.login(tRegisterParams);
      final call = loginSignUpRemoteDataSourceImpl.register;
      //assert
      expect(
          () => call(tRegisterParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.message, 'message', tServerException.message)));
      verify(mockErrorHandlerMiddleware.sendRequest(tRequestOptions));
    });
  });
}
