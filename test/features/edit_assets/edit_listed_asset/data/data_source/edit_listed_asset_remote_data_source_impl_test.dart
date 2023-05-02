import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/data/data_sources/edit_listed_asset_remote_datasource.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/data/models/delete_listed_asset_params.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/data/models/delete_listed_asset_response.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/data/models/put_listed_asset_params.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/data/models/put_listed_asset_response.dart';

import '../../../../../core/data/network/error_handler_middleware_test.mocks.dart';


Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late EditListedAssetRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    remoteDataSourceImpl =
        EditListedAssetRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('putListedAsset', () {
    final tPutListedAssetOptions = AppRequestOptions(
      RequestTypes.put,
      AppUrls.putListedAsset,
      PutListedAssetParams.tParams.toServerJson(),
    );
    test('should return PutListedAssetResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => PutListedAssetResponse.tResponse.toJson(),
      );
      //act
      final result =
          await remoteDataSourceImpl.putListedAsset(PutListedAssetParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tPutListedAssetOptions));
      expect(result, PutListedAssetResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.putListedAsset;
      //assert
      expect(
          () => call(PutListedAssetParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tPutListedAssetOptions));
    });
    
  });
  group('deleteListedAsset', () {
    final tDeleteListedAssetOptions = AppRequestOptions(
      RequestTypes.del,
      AppUrls.deleteListedAsset,
      DeleteListedAssetParams.tParams.toJson(),
    );
    test('should return DeleteListedAssetResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => DeleteListedAssetResponse.tResponse.toJson(),
      );
      //act
      final result =
          await remoteDataSourceImpl.deleteListedAsset(DeleteListedAssetParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tDeleteListedAssetOptions));
      expect(result, DeleteListedAssetResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.deleteListedAsset;
      //assert
      expect(
          () => call(DeleteListedAssetParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tDeleteListedAssetOptions));
    });
    
  });


}
    