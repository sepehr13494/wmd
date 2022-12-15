import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/assets_overview/assets_overview/data/data_sources/asset_overview_remote_datasource.dart';
import 'package:wmd/features/assets_overview/assets_overview/data/models/assets_overview_params.dart';
import 'package:wmd/features/assets_overview/assets_overview/data/models/assets_overview_response.dart';
import 'package:wmd/features/help/faq/data/data_sources/faq_remote_data_source.dart';
import 'package:wmd/features/help/faq/data/models/faq.dart';

import '../../../../../core/data/network/error_handler_middleware_test.mocks.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late FaqRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    remoteDataSourceImpl = FaqRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('get faqs', () {
    final tGetReqOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.faqsContent,
      AssetsOverviewParams.tParams.toJson(),
    );

    final tNoParams = NoParams();
    const tServerException = ServerException(message: 'test server message');

    test('should return FaqLoaded when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => Faq.tFaqListResponse,
      );
      //act
      final result = await remoteDataSourceImpl.getFAQs(tNoParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tGetReqOptions));
      expect(result, Faq.tFaqListParams);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(tServerException);
      //act
      final call = remoteDataSourceImpl.getFAQs;
      //assert
      expect(
          () => call(tNoParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tGetReqOptions));
    });
  });
}
