import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/data_sources/main_dashboard_remote_data_source.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/data_sources/main_dashboard_remote_data_source.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/models/net_worth_params.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/models/net_worth_response_obj.dart';
import 'package:wmd/features/dashboard/user_status/data/data_sources/user_status_remote_data_source.dart';
import 'package:wmd/features/dashboard/user_status/data/models/user_status.dart';

import '../../../../../core/data/network/error_handler_middleware_test.mocks.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late MainDashboardRemoteDataSourceImpl mainDashboardRemoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    mainDashboardRemoteDataSourceImpl =
        MainDashboardRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('get user net worth', () {
    final tGetNetWorthOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.getUserNetWorth,
      NetWorthParams.tNetWorthParams.toJson(),
    );
    test('should return UserStatus when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => NetWorthResponseObj.tNetWorthResponseObj.toJson(),
      );
      //act
      final result =
          await mainDashboardRemoteDataSourceImpl.userNetWorth(NetWorthParams.tNetWorthParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tGetNetWorthOptions));
      expect(result, NetWorthResponseObj.fromJson(NetWorthResponseObj.tNetWorthResponseObj.toJson()));
    });

    test('should throws ServerException when API call is not successful',
        () async {
      final tServerException = ServerException(message: 'exception message',data: {"test":"testData"});
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(tServerException);
      //act
      // final result = await loginSignUpRemoteDataSourceImpl.login(tLoginParams);
      final call = mainDashboardRemoteDataSourceImpl.userNetWorth;
      //assert
      expect(
          () => call(NetWorthParams.tNetWorthParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tGetNetWorthOptions));
    });
  });

}
