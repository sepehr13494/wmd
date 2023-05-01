import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/authentication/logout/data/data_sources/logout_remote_datasource.dart';
import 'package:wmd/features/authentication/logout/data/models/perform_logout_params.dart';
import 'package:wmd/features/authentication/logout/data/models/perform_logout_response.dart';

import '../../../../../core/data/network/error_handler_middleware_test.mocks.dart';


Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late LogoutRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    remoteDataSourceImpl =
        LogoutRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('performLogout', () {
    final tPerformLogoutOptions = AppRequestOptions(
      RequestTypes.post,
      AppUrls.performLogout,
      PerformLogoutParams.tParams.toJson(),
    );
    test('should return PerformLogoutResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => PerformLogoutResponse.tResponse.toJson(),
      );
      //act
      final result =
          await remoteDataSourceImpl.performLogout(PerformLogoutParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tPerformLogoutOptions));
      expect(result, PerformLogoutResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.performLogout;
      //assert
      expect(
          () => call(PerformLogoutParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tPerformLogoutOptions));
    });
    
  });


}
    