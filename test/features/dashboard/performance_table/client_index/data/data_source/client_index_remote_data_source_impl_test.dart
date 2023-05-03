import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/dashboard/performance_table/client_index/data/data_sources/client_index_remote_datasource.dart';
import 'package:wmd/features/dashboard/performance_table/client_index/data/models/get_client_index_params.dart';
import 'package:wmd/features/dashboard/performance_table/client_index/data/models/get_client_index_response.dart';

import '../../../../../../core/data/network/error_handler_middleware_test.mocks.dart';


Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late ClientIndexRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    remoteDataSourceImpl =
        ClientIndexRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('getClientIndex', () {
    final tGetClientIndexOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.getClientIndex,
      GetClientIndexParams.tParams.toJson(),
    );
    test('should return GetClientIndexResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => GetClientIndexResponse.tResponse.toJson(),
      );
      //act
      final result =
          await remoteDataSourceImpl.getClientIndex(GetClientIndexParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tGetClientIndexOptions));
      expect(result, GetClientIndexResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.getClientIndex;
      //assert
      expect(
          () => call(GetClientIndexParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tGetClientIndexOptions));
    });
    
  });


}
    