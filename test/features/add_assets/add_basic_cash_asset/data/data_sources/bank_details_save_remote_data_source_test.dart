import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/data/data_sources/bank_details_save_remote_data_source.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/data/models/bank_save_response_model.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/use_cases/post_bank_details_usecase.dart';

import '../../../../../core/data/network/error_handler_middleware_test.mocks.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late BankSaveRemoteDataSourceImpl bankSaveRemoteDataSourceImpl;
  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    bankSaveRemoteDataSourceImpl =
        BankSaveRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('post bank details', () {
    final tPostBankSaveRequestOptions = AppRequestOptions(RequestTypes.post,
        AppUrls.postBankDetails, BankSaveParams.tBankSaveParams.toJson());
    test('should return BankSaveResponse when API call is successful',
        () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => BankSaveResponseModel.tBankSaveResponse,
      );
      //act
      final result = await bankSaveRemoteDataSourceImpl
          .postBankDetails(BankSaveParams.tBankSaveParams);
      //assert
      verify(
          mockErrorHandlerMiddleware.sendRequest(tPostBankSaveRequestOptions));
      expect(
          result,
          BankSaveResponseModel.fromJson(
              BankSaveResponseModel.tBankSaveResponse));
    });

    test('should throws ServerException when API call is not successful',
        () async {
      final tServerException = ServerException(message: 'exception message');
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(tServerException);
      //act
      // final result = await loginSignUpRemoteDataSourceImpl.login(tLoginParams);
      final call = bankSaveRemoteDataSourceImpl.postBankDetails;
      //assert
      expect(
          () => call(BankSaveParams.tBankSaveParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.message, 'message', tServerException.message)));
      verify(
          mockErrorHandlerMiddleware.sendRequest(tPostBankSaveRequestOptions));
    });
  });
}
