import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/dashboard/performance_table/data/data_sources/performance_table_remote_datasource.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_asset_class_params.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_asset_class_response.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_benchmark_params.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_benchmark_response.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_custodian_performance_params.dart';
import 'package:wmd/features/dashboard/performance_table/data/models/get_custodian_performance_response.dart';

import '../../../../../core/data/network/error_handler_middleware_test.mocks.dart';


Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late PerformanceTableRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    remoteDataSourceImpl =
        PerformanceTableRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('getAssetClass', () {
    final tGetAssetClassOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.getAssetClass,
      GetAssetClassParams.tParams.toJson(),
    );
    test('should return GetAssetClassResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => {"assetClassPerformance":List<dynamic>.from(GetAssetClassResponse.tResponse.map((x) => x.toJson()))},
      );
      //act
      final result =
          await remoteDataSourceImpl.getAssetClass(GetAssetClassParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tGetAssetClassOptions));
      expect(result, GetAssetClassResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.getAssetClass;
      //assert
      expect(
          () => call(GetAssetClassParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tGetAssetClassOptions));
    });
    
  });
  group('getBenchmark', () {
    final tGetBenchmarkOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.getBenchmark,
      GetBenchmarkParams.tParams.toJson(),
    );
    test('should return GetBenchmarkResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => List<dynamic>.from(GetBenchmarkResponse.tResponse.map((x) => x.toJson())),
      );
      //act
      final result =
          await remoteDataSourceImpl.getBenchmark(GetBenchmarkParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tGetBenchmarkOptions));
      expect(result, GetBenchmarkResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.getBenchmark;
      //assert
      expect(
          () => call(GetBenchmarkParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tGetBenchmarkOptions));
    });
    
  });
  group('getCustodianPerformance', () {
    final tGetCustodianPerformanceOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.getCustodianPerformance,
      GetCustodianPerformanceParams.tParams.toJson(),
    );
    test('should return GetCustodianPerformanceResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => List<dynamic>.from(GetCustodianPerformanceResponse.tResponse.map((x) => x.toJson())),
      );
      //act
      final result =
          await remoteDataSourceImpl.getCustodianPerformance(GetCustodianPerformanceParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tGetCustodianPerformanceOptions));
      expect(result, GetCustodianPerformanceResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.getCustodianPerformance;
      //assert
      expect(
          () => call(GetCustodianPerformanceParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tGetCustodianPerformanceOptions));
    });
    
  });


}
    