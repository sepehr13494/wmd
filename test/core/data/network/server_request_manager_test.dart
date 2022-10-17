import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/models/app_request_options.dart';

import 'server_request_manager_test.mocks.dart';

@GenerateMocks([Dio])
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/env/.env");
  final String appBaseUrl = dotenv.env['BASE_URL']!;

  late MockDio mockDio;
  late ServerRequestManager serverRequestManager;
  final tResponse = Response(
      requestOptions: RequestOptions(path: "path"),
      data: {"test": 1},
      statusCode: 200);
  setUp(() {
    mockDio = MockDio();
    serverRequestManager = ServerRequestManager(mockDio);
  });

  group('for every requests goes to server', () {

    test('Post request', () async {
      final tAppRequestOptions = AppRequestOptions(RequestTypes.post, "1", {"test":"test"});
      //arrange
      String baseUrl = tAppRequestOptions.fullUrl ? "" : appBaseUrl;
      when(
        mockDio.post(
          any,
          data: anyNamed("data"),
        ),
      ).thenAnswer((_) async => tResponse);
      //act
      final result = await serverRequestManager.sendRequest(tAppRequestOptions);
      //assert
      verify(mockDio.post(baseUrl+tAppRequestOptions.url, data: tAppRequestOptions.body,onSendProgress: tAppRequestOptions.onSendProgress));
      expect(result, equals(tResponse));
    });

    test('Get request', () async {
      final tAppRequestOptions = AppRequestOptions(RequestTypes.get, "1", {"test":"test"});
      //arrange
      String baseUrl = tAppRequestOptions.fullUrl ? "" : appBaseUrl;
      when(
        mockDio.get(
          any,
          queryParameters: anyNamed("queryParameters"),
        ),
      ).thenAnswer((_) async => tResponse);
      //act
      final result = await serverRequestManager.sendRequest(tAppRequestOptions);
      //assert
      verify(mockDio.get(baseUrl+tAppRequestOptions.url, queryParameters: tAppRequestOptions.body));
      expect(result, equals(tResponse));
    });

    test('Del request', () async {
      final tAppRequestOptions = AppRequestOptions(RequestTypes.del, "1", {"test":"test"});
      //arrange
      String baseUrl = tAppRequestOptions.fullUrl ? "" : appBaseUrl;
      when(
        mockDio.delete(
          any,
          data: anyNamed("data"),
        ),
      ).thenAnswer((_) async => tResponse);
      //act
      final result = await serverRequestManager.sendRequest(tAppRequestOptions);
      //assert
      verify(mockDio.delete(baseUrl+tAppRequestOptions.url, data: tAppRequestOptions.body));
      expect(result, equals(tResponse));
    });

    test('Put request', () async {
      final tAppRequestOptions = AppRequestOptions(RequestTypes.put, "1", {"test":"test"});
      //arrange
      String baseUrl = tAppRequestOptions.fullUrl ? "" : appBaseUrl;
      when(
        mockDio.put(
          any,
          data: anyNamed("data"),
        ),
      ).thenAnswer((_) async => tResponse);
      //act
      final result = await serverRequestManager.sendRequest(tAppRequestOptions);
      //assert
      verify(mockDio.put(baseUrl+tAppRequestOptions.url, data: tAppRequestOptions.body));
      expect(result, equals(tResponse));
    });

    test('Patch request', () async {
      final tAppRequestOptions = AppRequestOptions(RequestTypes.patch, "1", {"test":"test"});
      //arrange
      String baseUrl = tAppRequestOptions.fullUrl ? "" : appBaseUrl;
      when(
        mockDio.patch(
          any,
          data: anyNamed("data"),
        ),
      ).thenAnswer((_) async => tResponse);
      //act
      final result = await serverRequestManager.sendRequest(tAppRequestOptions);
      //assert
      verify(mockDio.patch(baseUrl+tAppRequestOptions.url, data: tAppRequestOptions.body));
      expect(result, equals(tResponse));
    });

  });
}
