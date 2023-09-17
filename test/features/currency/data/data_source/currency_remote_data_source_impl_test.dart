import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/currency/data/data_sources/currency_remote_datasource.dart';
import 'package:wmd/features/currency/data/models/get_currency_params.dart';
import 'package:wmd/features/currency/data/models/get_currency_response.dart';

import '../../../../core/data/network/error_handler_middleware_test.mocks.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late CurrencyRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    remoteDataSourceImpl =
        CurrencyRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('getCurrency', () {
    final tGetCurrencyOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.getCurrency,
      GetCurrencyConversionParams.tParams.toJson(),
    );
    test('should return GetCurrencyResponse when API call is successful',
        () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => GetCurrencyConversionResponse.tResponse.toJson(),
      );
      //act
      final result = await remoteDataSourceImpl
          .getCurrency(GetCurrencyConversionParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tGetCurrencyOptions));
      expect(result, GetCurrencyConversionResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.getCurrency;
      //assert
      expect(
          () => call(GetCurrencyConversionParams.tParams),
          throwsA(const TypeMatcher<ServerException>().having(
              (e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tGetCurrencyOptions));
    });
  });
}
