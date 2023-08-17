import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/assets_overview/portfolio_tab2/data/data_sources/portfolio_tab2_remote_datasource.dart';
import 'package:wmd/features/assets_overview/portfolio_tab2/data/models/get_portfolio_allocation_params.dart';
import 'package:wmd/features/assets_overview/portfolio_tab2/data/models/get_portfolio_allocation_response.dart';
import 'package:wmd/features/assets_overview/portfolio_tab2/data/models/get_portfolio_tab_params.dart';
import 'package:wmd/features/assets_overview/portfolio_tab2/data/models/get_portfolio_tab_response.dart';

import '../../../../../core/data/network/error_handler_middleware_test.mocks.dart';


Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late PortfolioTab2RemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    remoteDataSourceImpl =
        PortfolioTab2RemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('getPortfolioAllocation', () {
    final tGetPortfolioAllocationOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.getPortfolioAllocation,
      GetPortfolioAllocationParams.tParams.toJson(),
    );
    test('should return GetPortfolioAllocationResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => List<dynamic>.from(GetPortfolioAllocationResponse.tResponse.map((x) => x.toJson())),
      );
      //act
      final result =
          await remoteDataSourceImpl.getPortfolioAllocation(GetPortfolioAllocationParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tGetPortfolioAllocationOptions));
      expect(result, GetPortfolioAllocationResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.getPortfolioAllocation;
      //assert
      expect(
          () => call(GetPortfolioAllocationParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tGetPortfolioAllocationOptions));
    });
    
  });
  group('getPortfolioTab', () {
    final tGetPortfolioTabOptions = AppRequestOptions(
      RequestTypes.get,
      "${AppUrls.getPortfolioTab}${GetPortfolioTabParams.tParams.ownerId}/portfolio/${GetPortfolioTabParams.tParams.portfolioId}",
      null,
    );
    test('should return GetPortfolioTabResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => GetPortfolioTabResponse.tResponse.first.toJson(),
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
    