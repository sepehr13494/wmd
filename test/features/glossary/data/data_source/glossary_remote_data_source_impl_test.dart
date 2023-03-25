import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/glossary/data/data_sources/glossary_remote_datasource.dart';
import 'package:wmd/features/glossary/data/models/get_glossaries_params.dart';
import 'package:wmd/features/glossary/data/models/get_glossaries_response.dart';

import '../../../../core/data/network/error_handler_middleware_test.mocks.dart';


Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late GlossaryRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    remoteDataSourceImpl =
        GlossaryRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('getGlossaries', () {
    final tGetGlossariesOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.getGlossaries,
      GetGlossariesParams.tParams.toJson(),
    );
    test('should return GetGlossariesResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => List<dynamic>.from(GetGlossariesResponse.tResponse.map((x) => x.toJson())),
      );
      //act
      final result =
          await remoteDataSourceImpl.getGlossaries(GetGlossariesParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tGetGlossariesOptions));
      expect(result, GetGlossariesResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.getGlossaries;
      //assert
      expect(
          () => call(GetGlossariesParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tGetGlossariesOptions));
    });
    
  });


}
    