import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/safe_device/data/data_sources/safe_device_local_datasource.dart';
import 'package:wmd/features/safe_device/data/models/is_safe_device_params.dart';
import 'package:wmd/features/safe_device/data/models/is_safe_device_response.dart';

import '../../../../core/data/network/error_handler_middleware_test.mocks.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');

  late SafeDeviceLocalDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    remoteDataSourceImpl = SafeDeviceLocalDataSourceImpl();
  });

  group('isSafeDevice', () {
    test('should return IsSafeDeviceResponse when API call is successful',
        () async {
      // arrange
      when(remoteDataSourceImpl.isSafeDevice(IsSafeDeviceParams.tParams))
          .thenAnswer(
        (_) async => IsSafeDeviceResponse.tResponse,
      );
      //act
      final result =
          await remoteDataSourceImpl.isSafeDevice(IsSafeDeviceParams.tParams);
      //assert
      expect(result, IsSafeDeviceResponse.tResponse);
    });

    test('should throws Exception when method call is not successful',
        () async {
      //arrange
      when(remoteDataSourceImpl.isSafeDevice(IsSafeDeviceParams.tParams))
          .thenThrow(Exception());
      //act
      final call = remoteDataSourceImpl.isSafeDevice;
      //assert
      expect(
          () => call(IsSafeDeviceParams.tParams),
          throwsA(const TypeMatcher<ServerException>().having(
              (e) => e.data, 'data', ServerException.tServerException.data)));
      verify(remoteDataSourceImpl.isSafeDevice(IsSafeDeviceParams.tParams));
    });
  });
}
