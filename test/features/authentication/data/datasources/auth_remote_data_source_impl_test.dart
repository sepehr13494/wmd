import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/error_handler_middleware.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:wmd/features/authentication/data/models/login_response_model.dart';
import 'package:wmd/features/authentication/usecases/post_login_usecase.dart';

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
    final tLoginParams =
        LoginParams(email: 'test@yopmail.com', password: 'Passw0rd');
    // final tLoginResponse = LoginResponse(
    //     accessToken: 'test accessToken',
    //     refreshToken: 'test refreshToken',
    //     idToken: ' test idToken',
    //     tokenType: 'test tokenType');
    final tLoginResponse = LoginResponse.fromJson(jsonMap);
    final tRequestOptions = AppRequestOptions(
      RequestTypes.post,
      "url",
      tLoginParams.toJson(),
    );
    test('should return LoginResponse when API call is successful', () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenAnswer((_) async => await jsonMap);
      //act
      final result = await authRemoteDataSourceImpl.login(tLoginParams);
      await mockErrorHandlerMiddleware.sendRequest(tRequestOptions);
      //assert
      verify(await mockErrorHandlerMiddleware.sendRequest(tRequestOptions))
          .called(1);
      // verify(LoginResponse.fromJson(jsonMap));
      expect(result, tLoginResponse);
    });
  });
}
