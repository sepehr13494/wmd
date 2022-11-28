import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/error_handler_middleware.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';

import 'error_handler_middleware_test.mocks.dart';

@GenerateMocks([ServerRequestManager, ErrorHandlerMiddleware])
void main() {
  group('error handler middleware test', () {
    final tAppRequestOptions =
        AppRequestOptions(RequestTypes.put, "testUrl", null);
    final tServerException = ServerException(message: "test");

    late MockServerRequestManager mockRequestManager;
    late ErrorHandlerMiddleware errorHandlerMiddleware;
    setUp(() {
      mockRequestManager = MockServerRequestManager();
      errorHandlerMiddleware = ErrorHandlerMiddleware(mockRequestManager);
    });
    test('test when request manager returns a response with status code 200',
        () async {
      final tResponse = Response(
          requestOptions: RequestOptions(path: "path"),
          data: {"test": 1},
          statusCode: 200);
      //arrange
      when(mockRequestManager.sendRequest(any))
          .thenAnswer((_) async => tResponse);
      //act
      final result =
          await errorHandlerMiddleware.sendRequest(tAppRequestOptions);
      //assert
      verify(mockRequestManager.sendRequest(tAppRequestOptions));
      expect(result, equals(tResponse.data));
    });

    test('test when request manager returns a response with statusCode 400',
        () async {
      final tResponse = Response(
          requestOptions: RequestOptions(path: "path"),
          data: {"message": "1"},
          statusCode: 400);
      //arrange
      when(mockRequestManager.sendRequest(any))
          .thenAnswer((_) async => tResponse);
      //act
      final call = errorHandlerMiddleware.sendRequest;
      //assert
      expect(
          () => call(tAppRequestOptions),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.type, 'type', ExceptionType.normal)));
      verify(mockRequestManager.sendRequest(tAppRequestOptions));
    });

    test(
        'test when request manager returns a response with statusCode 401 (auth error)',
        () async {
      final tResponse = Response(
          requestOptions: RequestOptions(path: "path"),
          data: {"message": "1"},
          statusCode: 401);
      //arrange
      when(mockRequestManager.sendRequest(any))
          .thenAnswer((_) async => tResponse);
      //act
      final call = errorHandlerMiddleware.sendRequest;
      //assert
      expect(
          () => call(tAppRequestOptions),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.type, 'type', ExceptionType.auth)));
      verify(mockRequestManager.sendRequest(tAppRequestOptions));
    });

    test('test when request manager throws ServerException', () async {
      //arrange
      when(mockRequestManager.sendRequest(any)).thenThrow(tServerException);
      //act
      final call = errorHandlerMiddleware.sendRequest;
      //assert
      expect(
          () => call(tAppRequestOptions),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.message, 'message', tServerException.message)));
      verify(mockRequestManager.sendRequest(tAppRequestOptions));
    });

    test('test when request manager throws other Exception', () async {
      //arrange
      final tOtherException = Exception("test message");
      when(mockRequestManager.sendRequest(any)).thenThrow(tOtherException);
      //act
      final call = errorHandlerMiddleware.sendRequest;
      //assert
      expect(
          () => call(tAppRequestOptions),
          throwsA(const TypeMatcher<ServerException>().having(
              (e) => e.message, 'message', tOtherException.toString())));
      verify(mockRequestManager.sendRequest(tAppRequestOptions));
    });
  });
}
