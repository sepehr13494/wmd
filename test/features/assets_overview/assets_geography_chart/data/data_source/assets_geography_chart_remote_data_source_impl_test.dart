import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/data/data_sources/assets_geography_chart_remote_datasource.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/data/models/get_assets_geography_params.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/data/models/get_assets_geography_response.dart';

import '../../../../../core/data/network/error_handler_middleware_test.mocks.dart';


Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late AssetsGeographyChartRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    remoteDataSourceImpl =
        AssetsGeographyChartRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('getAssetsGeography', () {
    final tGetAssetsGeographyOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.getAssetsGeography,
      GetAssetsGeographyParams.tParams.toJson(),
    );
    test('should return GetAssetsGeographyResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => List<dynamic>.from(GetAssetsGeographyResponse.tResponse.map((x) => x.toJson())),
      );
      //act
      final result =
          await remoteDataSourceImpl.getAssetsGeography(GetAssetsGeographyParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tGetAssetsGeographyOptions));
      expect(result, GetAssetsGeographyResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.getAssetsGeography;
      //assert
      expect(
          () => call(GetAssetsGeographyParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tGetAssetsGeographyOptions));
    });
    
  });


}
    