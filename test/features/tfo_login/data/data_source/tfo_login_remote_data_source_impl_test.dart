import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/add_assets/tfo_login/data/data_sources/tfo_login_remote_datasource.dart';
import 'package:wmd/features/add_assets/tfo_login/data/models/get_mandates_params.dart';
import 'package:wmd/features/add_assets/tfo_login/data/models/get_mandates_response.dart';
import 'package:wmd/features/add_assets/tfo_login/data/models/login_tfo_account_params.dart';
import 'package:wmd/features/add_assets/tfo_login/data/models/login_tfo_account_response.dart';
import '../../../../core/data/network/error_handler_middleware_test.mocks.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late TfoLoginRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    remoteDataSourceImpl =
        TfoLoginRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('getMandates', () {
    final tGetMandatesOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.getMandate,
      GetMandatesParams.tParams.toJson(),
    );
    test('should return GetMandatesResponse when API call is successful',
        () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => GetMandatesResponse.tResponse.toJson(),
      );
      //act
      final result =
          await remoteDataSourceImpl.getMandates(GetMandatesParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tGetMandatesOptions));
      expect(result, GetMandatesResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.getMandates;
      //assert
      expect(
          () => call(GetMandatesParams.tParams),
          throwsA(const TypeMatcher<ServerException>().having(
              (e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tGetMandatesOptions));
    });
  });
  group('loginTfoAccount', () {
    final tLoginTfoAccountOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.postMandates,
      LoginTfoAccountParams.tParams.toJson(),
    );
    test('should return LoginTfoAccountResponse when API call is successful',
        () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => LoginTfoAccountResponse.tResponse.toJson(),
      );
      //act
      final result = await remoteDataSourceImpl
          .loginTfoAccount(LoginTfoAccountParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tLoginTfoAccountOptions));
      expect(result, LoginTfoAccountResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.loginTfoAccount;
      //assert
      expect(
          () => call(LoginTfoAccountParams.tParams),
          throwsA(const TypeMatcher<ServerException>().having(
              (e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tLoginTfoAccountOptions));
    });
  });
}
