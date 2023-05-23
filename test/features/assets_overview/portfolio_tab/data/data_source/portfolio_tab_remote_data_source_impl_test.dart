import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/assets_overview/portfolio_tab/data/data_sources/portfolio_tab_remote_datasource.dart';
import 'package:wmd/features/assets_overview/portfolio_tab/data/models/get_portfolio_tab_params.dart';
import 'package:wmd/features/assets_overview/portfolio_tab/data/models/get_portfolio_tab_response.dart';

import '../../../../../core/data/network/error_handler_middleware_test.mocks.dart';


Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late PortfolioTabRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    remoteDataSourceImpl =
        PortfolioTabRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('getPortfolioTab', () {
    final tGetPortfolioTabOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.getPortfolioTab,
      GetPortfolioTabParams.tParams.toJson(),
    );
    test('should return GetPortfolioTabResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => List<dynamic>.from(GetPortfolioTabResponse.tResponse.map((x) => x.toJson())),
      );
      //act
      final result =
          await remoteDataSourceImpl.getPortfolioTab(GetPortfolioTabParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tGetPortfolioTabOptions));
      expect(result, GetPortfolioTabResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.getPortfolioTab;
      //assert
      expect(
          () => call(GetPortfolioTabParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tGetPortfolioTabOptions));
    });
    
  });


}
    