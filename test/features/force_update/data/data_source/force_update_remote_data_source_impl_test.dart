import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/force_update/data/data_sources/force_update_remote_datasource.dart';
import 'package:wmd/features/force_update/data/models/get_force_update_params.dart';
import 'package:wmd/features/force_update/data/models/get_force_update_response.dart';

import '../../../../core/data/network/error_handler_middleware_test.mocks.dart';


Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late ForceUpdateRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    remoteDataSourceImpl =
        ForceUpdateRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('getForceUpdate', () {
    final tGetForceUpdateOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.getForceUpdate,
      GetForceUpdateParams.tParams.toJson(),
    );
    test('should return GetForceUpdateResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => GetForceUpdateResponse.tResponse.toJson(),
      );
      //act
      final result =
          await remoteDataSourceImpl.getForceUpdate(GetForceUpdateParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tGetForceUpdateOptions));
      expect(result, GetForceUpdateResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.getForceUpdate;
      //assert
      expect(
          () => call(GetForceUpdateParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tGetForceUpdateOptions));
    });
    
  });


}
    