import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/data/data_sources/edit_other_assets_remote_datasource.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/data/models/delete_other_assets_params.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/data/models/delete_other_assets_response.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/data/models/put_other_assets_params.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/data/models/put_other_assets_response.dart';

import '../../../../../core/data/network/error_handler_middleware_test.mocks.dart';


Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late EditOtherAssetsRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    remoteDataSourceImpl =
        EditOtherAssetsRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('putOtherAssets', () {
    final tPutOtherAssetsOptions = AppRequestOptions(
      RequestTypes.put,
      AppUrls.putOtherAssets,
      PutOtherAssetsParams.tParams.toServerJson(),
    );
    test('should return PutOtherAssetsResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => PutOtherAssetsResponse.tResponse.toJson(),
      );
      //act
      final result =
          await remoteDataSourceImpl.putOtherAssets(PutOtherAssetsParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tPutOtherAssetsOptions));
      expect(result, PutOtherAssetsResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.putOtherAssets;
      //assert
      expect(
          () => call(PutOtherAssetsParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tPutOtherAssetsOptions));
    });
    
  });
  group('deleteOtherAssets', () {
    final tDeleteOtherAssetsOptions = AppRequestOptions(
      RequestTypes.del,
      AppUrls.deleteOtherAssets,
      DeleteOtherAssetsParams.tParams.toJson(),
    );
    test('should return DeleteOtherAssetsResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => DeleteOtherAssetsResponse.tResponse.toJson(),
      );
      //act
      final result =
          await remoteDataSourceImpl.deleteOtherAssets(DeleteOtherAssetsParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tDeleteOtherAssetsOptions));
      expect(result, DeleteOtherAssetsResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.deleteOtherAssets;
      //assert
      expect(
          () => call(DeleteOtherAssetsParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tDeleteOtherAssetsOptions));
    });
    
  });


}
    