import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/settings/linked_accounts/data/data_sources/linked_accounts_remote_datasource.dart';
import 'package:wmd/features/settings/linked_accounts/data/models/get_linked_accounts_params.dart';
import 'package:wmd/features/settings/linked_accounts/data/models/get_linked_accounts_response.dart';
import '../../../../../core/data/network/error_handler_middleware_test.mocks.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late LinkedAccountsRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    remoteDataSourceImpl =
        LinkedAccountsRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('getLinkedAccounts', () {
    final tGetLinkedAccountsOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.getLinkedAccounts,
      GetLinkedAccountsParams.tParams.toJson(),
    );
    test('should return GetLinkedAccountsResponse when API call is successful',
        () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => List<dynamic>.from(
            GetLinkedAccountsResponse.tResponse.map((x) => x.toJson())),
      );
      //act
      final result = await remoteDataSourceImpl
          .getLinkedAccounts(GetLinkedAccountsParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tGetLinkedAccountsOptions));
      expect(result, GetLinkedAccountsResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.getLinkedAccounts;
      //assert
      expect(
          () => call(GetLinkedAccountsParams.tParams),
          throwsA(const TypeMatcher<ServerException>().having(
              (e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tGetLinkedAccountsOptions));
    });
  });
}
