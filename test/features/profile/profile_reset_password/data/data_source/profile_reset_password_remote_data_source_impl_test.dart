import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/profile/profile_reset_password/data/data_sources/profile_reset_password_remote_datasource.dart';
import 'package:wmd/features/profile/profile_reset_password/data/models/reset_params.dart';
import 'package:wmd/features/profile/profile_reset_password/data/models/reset_response.dart';

import '../../../../../core/data/network/error_handler_middleware_test.mocks.dart';


Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late ProfileResetPasswordRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    remoteDataSourceImpl =
        ProfileResetPasswordRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('reset', () {
    final tResetOptions = AppRequestOptions(
      RequestTypes.post,
      AppUrls.reset,
      ResetParams.tParams.toJson(),
    );
    test('should return ResetResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => ResetResponse.tResponse.toJson(),
      );
      //act
      final result =
          await remoteDataSourceImpl.reset(ResetParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tResetOptions));
      expect(result, ResetResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.reset;
      //assert
      expect(
          () => call(ResetParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tResetOptions));
    });
    
  });


}
    