import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/data_sources/dashboard_charts_remote_datasource.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/models/get_allocation_params.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/models/get_allocation_response.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/models/get_geographic_params.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/models/get_geographic_response.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/models/get_pie_params.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/models/get_pie_response.dart';

import '../../../../../core/data/network/error_handler_middleware_test.mocks.dart';


Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late DashboardChartsRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    remoteDataSourceImpl =
        DashboardChartsRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('getAllocation', () {
    final tGetAllocationOptions = AppRequestOptions(
      RequestTypes.get,
      "${AppUrls.getAllocation}${GetAllocationParams.tParams.ownerId}/history",
      {
        "To":GetAllocationParams.tParams.to,
      },
    );
    test('should return GetAllocationResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
            (_) async => List<dynamic>.from(GetAllocationResponse.tResponse.map((x) => x.toJson())),
      );
      //act
      final result =
          await remoteDataSourceImpl.getAllocation(GetAllocationParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tGetAllocationOptions));
      expect(result, GetAllocationResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.getAllocation;
      //assert
      expect(
          () => call(GetAllocationParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tGetAllocationOptions));
    });
  });

  group('getGeographic', () {
    final tGetGeographicOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.getGeographic,
      GetGeographicParams.tParams.toJson(),
    );
    test('should return GetGeographicResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
            (_) async => List<dynamic>.from(GetGeographicResponse.tResponse.map((x) => x.toJson())),
      );
      //act
      final result =
          await remoteDataSourceImpl.getGeographic(GetGeographicParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tGetGeographicOptions));
      expect(result, GetGeographicResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.getGeographic;
      //assert
      expect(
          () => call(GetGeographicParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tGetGeographicOptions));
    });
  });

  group('getPie', () {
    final tGetPieOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.getPie,
      GetPieParams.tParams.toJson(),
    );
    test('should return GetPieResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => List<dynamic>.from(GetPieResponse.tResponse.map((x) => x.toJson())),
      );
      //act
      final result =
          await remoteDataSourceImpl.getPie(GetPieParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tGetPieOptions));
      expect(result, GetPieResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.getPie;
      //assert
      expect(
          () => call(GetPieParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tGetPieOptions));
    });
  });


}
    