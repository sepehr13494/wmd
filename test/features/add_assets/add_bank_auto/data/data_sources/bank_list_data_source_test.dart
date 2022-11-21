import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/data/data_sources/bank_list_data_source.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/data/models/bank_list_response.dart';

import '../../../../../core/data/network/error_handler_middleware_test.mocks.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late BankListRemoteDataSourceImpl bankListRemoteDataSourceImpl;
  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    bankListRemoteDataSourceImpl =
        BankListRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('get popular banks', () {
    final getPopularBankListRequestOptions =
        AppRequestOptions(RequestTypes.get, AppUrls.getPopularBankList, null);
    test('should return BankResponse list when API call is successful',
        () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => List.generate(2, (index) => BankResponse.tBankResponse),
      );
      //act
      final result =
          await bankListRemoteDataSourceImpl.getPopularBankList(null);
      //assert
      verify(mockErrorHandlerMiddleware
          .sendRequest(getPopularBankListRequestOptions));
      expect(
          result,
          List.generate(
              2, (index) => BankResponse.fromJson(BankResponse.tBankResponse)));
    });

    test('should throws ServerException when API call is not successful',
        () async {
      final tServerException = ServerException(message: 'exception message');
      //arrange
      when(mockErrorHandlerMiddleware
              .sendRequest(getPopularBankListRequestOptions))
          .thenThrow(tServerException);
      final call = bankListRemoteDataSourceImpl.getPopularBankList;
      //assert
      expect(
          () => call(null),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.message, 'message', tServerException.message)));
      verify(mockErrorHandlerMiddleware
          .sendRequest(getPopularBankListRequestOptions));
    });
  });

  group('get banks', () {
    final getBankListRequestOptions =
        AppRequestOptions(RequestTypes.get, AppUrls.getBankList, null);
    test('should return BankResponse list when API call is successful',
        () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => List.generate(3, (index) => BankResponse.tBankResponse),
      );
      //act
      final result = await bankListRemoteDataSourceImpl.getBankList(NoParams());
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(getBankListRequestOptions));
      expect(
          result,
          List.generate(
              3, (index) => BankResponse.fromJson(BankResponse.tBankResponse)));
    });

    test('should throws ServerException when API call is not successful',
        () async {
      final tServerException = ServerException(message: 'exception message');
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(tServerException);
      final call = bankListRemoteDataSourceImpl.getBankList;
      //assert
      expect(
          () => call(NoParams()),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.message, 'message', tServerException.message)));
      verify(mockErrorHandlerMiddleware.sendRequest(getBankListRequestOptions));
    });
  });
}
