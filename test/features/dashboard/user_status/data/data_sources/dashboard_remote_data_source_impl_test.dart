import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/dashboard/user_status/data/data_sources/user_status_remote_data_source.dart';
import 'package:wmd/features/dashboard/user_status/data/models/user_status.dart';

import '../../../../../core/data/network/error_handler_middleware_test.mocks.dart';

void main() {
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late UserStatusRemoteDataSourceImpl dashboardRemoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    dashboardRemoteDataSourceImpl =
        UserStatusRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('get user Status', () {
    final tGetUserRequestOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.getUserStatus,
      null,
    );
    test('should return UserStatus when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => UserStatus.tUserStatusResponse,
      );
      //act
      final result =
          await dashboardRemoteDataSourceImpl.getUserStatus(NoParams());
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tGetUserRequestOptions));
      expect(result, UserStatus.fromJson(UserStatus.tUserStatusResponse));
    });

    test('should throws ServerException when API call is not successful',
        () async {
      final tServerException = ServerException(message: 'exception message');
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(tServerException);
      //act
      // final result = await loginSignUpRemoteDataSourceImpl.login(tLoginParams);
      final call = dashboardRemoteDataSourceImpl.getUserStatus;
      //assert
      expect(
          () => call(NoParams()),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.message, 'message', tServerException.message)));
      verify(mockErrorHandlerMiddleware.sendRequest(tGetUserRequestOptions));
    });
  });
}
