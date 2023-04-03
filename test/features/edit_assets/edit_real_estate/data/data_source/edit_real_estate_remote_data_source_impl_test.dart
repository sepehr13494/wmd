import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/data/data_sources/edit_real_estate_remote_datasource.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/data/models/delete_real_estate_params.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/data/models/delete_real_estate_response.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/data/models/put_real_estate_params.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/data/models/put_real_estate_response.dart';

import '../../../../../core/data/network/error_handler_middleware_test.mocks.dart';


Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late EditRealEstateRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    remoteDataSourceImpl =
        EditRealEstateRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('putRealEstate', () {
    final tPutRealEstateOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.putRealEstate,
      PutRealEstateParams.tParams.toJson(),
    );
    test('should return PutRealEstateResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => PutRealEstateResponse.tResponse.toJson(),
      );
      //act
      final result =
          await remoteDataSourceImpl.putRealEstate(PutRealEstateParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tPutRealEstateOptions));
      expect(result, PutRealEstateResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.putRealEstate;
      //assert
      expect(
          () => call(PutRealEstateParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tPutRealEstateOptions));
    });
    
  });
  group('deleteRealEstate', () {
    final tDeleteRealEstateOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.deleteRealEstate,
      DeleteRealEstateParams.tParams.toJson(),
    );
    test('should return DeleteRealEstateResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => DeleteRealEstateResponse.tResponse.toJson(),
      );
      //act
      final result =
          await remoteDataSourceImpl.deleteRealEstate(DeleteRealEstateParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tDeleteRealEstateOptions));
      expect(result, DeleteRealEstateResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.deleteRealEstate;
      //assert
      expect(
          () => call(DeleteRealEstateParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tDeleteRealEstateOptions));
    });
    
  });


}
    