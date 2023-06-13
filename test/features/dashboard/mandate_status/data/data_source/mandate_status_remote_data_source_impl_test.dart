import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/dashboard/mandate_status/data/data_sources/mandate_status_remote_datasource.dart';
import 'package:wmd/features/dashboard/mandate_status/data/models/delete_mandate_params.dart';
import 'package:wmd/features/dashboard/mandate_status/data/models/delete_mandate_response.dart';
import 'package:wmd/features/dashboard/mandate_status/data/models/get_mandate_status_params.dart';
import 'package:wmd/features/dashboard/mandate_status/data/models/get_mandate_status_response.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late MandateStatusRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    remoteDataSourceImpl =
        MandateStatusRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('getMandateStatus', () {
    final tGetMandateStatusOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.getMandateStatus,
      GetMandateStatusParams.tParams.toJson(),
    );
    test('should return GetMandateStatusResponse when API call is successful',
        () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => List<dynamic>.from(
            GetMandateStatusResponse.tResponse.map((x) => x.toJson())),
      );
      //act
      final result = await remoteDataSourceImpl
          .getMandateStatus(GetMandateStatusParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tGetMandateStatusOptions));
      expect(result, GetMandateStatusResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.getMandateStatus;
      //assert
      expect(
          () => call(GetMandateStatusParams.tParams),
          throwsA(const TypeMatcher<ServerException>().having(
              (e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tGetMandateStatusOptions));
    });
  });
  group('deleteMandate', () {
    final tDeleteMandateOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.deleteMandate,
      DeleteMandateParams.tParams.toJson(),
    );
    test('should return DeleteMandateResponse when API call is successful',
        () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => DeleteMandateResponse.tResponse,
      );
      //act
      final result =
          await remoteDataSourceImpl.deleteMandate(DeleteMandateParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tDeleteMandateOptions));
      expect(result, DeleteMandateResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.deleteMandate;
      //assert
      expect(
          () => call(DeleteMandateParams.tParams),
          throwsA(const TypeMatcher<ServerException>().having(
              (e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tDeleteMandateOptions));
    });
  });
}
