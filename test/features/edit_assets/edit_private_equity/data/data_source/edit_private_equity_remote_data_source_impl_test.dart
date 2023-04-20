import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/data/data_sources/edit_private_equity_remote_datasource.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/data/models/delete_private_equity_params.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/data/models/delete_private_equity_response.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/data/models/put_private_equity_params.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/data/models/put_private_equity_response.dart';

import '../../../../../core/data/network/error_handler_middleware_test.mocks.dart';


Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late EditPrivateEquityRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    remoteDataSourceImpl =
        EditPrivateEquityRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('putPrivateEquity', () {
    final tPutPrivateEquityOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.putPrivateEquity,
      PutPrivateEquityParams.tParams.toJson(),
    );
    test('should return PutPrivateEquityResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => PutPrivateEquityResponse.tResponse.toJson(),
      );
      //act
      final result =
          await remoteDataSourceImpl.putPrivateEquity(PutPrivateEquityParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tPutPrivateEquityOptions));
      expect(result, PutPrivateEquityResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.putPrivateEquity;
      //assert
      expect(
          () => call(PutPrivateEquityParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tPutPrivateEquityOptions));
    });
    
  });
  group('deletePrivateEquity', () {
    final tDeletePrivateEquityOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.deletePrivateEquity,
      DeletePrivateEquityParams.tParams.toJson(),
    );
    test('should return DeletePrivateEquityResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => DeletePrivateEquityResponse.tResponse.toJson(),
      );
      //act
      final result =
          await remoteDataSourceImpl.deletePrivateEquity(DeletePrivateEquityParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tDeletePrivateEquityOptions));
      expect(result, DeletePrivateEquityResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.deletePrivateEquity;
      //assert
      expect(
          () => call(DeletePrivateEquityParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tDeletePrivateEquityOptions));
    });
    
  });


}
    