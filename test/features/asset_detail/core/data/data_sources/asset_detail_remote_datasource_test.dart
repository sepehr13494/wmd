import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/data/models/bank_list_response.dart';
import 'package:wmd/features/asset_detail/bank_account/data/models/bank_account_response.dart';
import 'package:wmd/features/asset_detail/core/data/data_sources/asset_detail_remote_datasource.dart';
import 'package:wmd/features/asset_detail/core/data/models/get_detail_params.dart';

import '../../../../../core/data/network/error_handler_middleware_test.mocks.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late AssetDetailRemoteDataSourceImpl assetDetailRemoteDataSourceImpl;
  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    assetDetailRemoteDataSourceImpl =
        AssetDetailRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('getDetails Bank Accounts test', () {
    GetDetailParams params =
        GetDetailParams(type: 'BankAccount', assetId: 'assetId');
    test('should return getDetails resp when API call is successful', () async {
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => BankAccountResponse.tBankAccountResponse,
      );
      //act
      final result = await assetDetailRemoteDataSourceImpl.getDetail(params);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(any));
      expect(
          result,
          BankAccountResponse.fromJson(
              BankAccountResponse.tBankAccountResponse));
    });

    test('should throws ServerException when API call is not successful',
        () async {
      final tServerException = ServerException(message: 'exception message');
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(tServerException);
      final call = assetDetailRemoteDataSourceImpl.getDetail;

      //assert
      expect(
          () => call(params),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.message, 'message', tServerException.message)));
      verify(mockErrorHandlerMiddleware.sendRequest(any));
    });
  });

  // group('GetDetails server exceptions test', () {
  //   GetDetailParams params = GetDetailParams(type: '', assetId: 'assetId');

  //   test('should throws ServerException when API call is not successful',
  //       () async {
  //     final tServerException = ServerException(message: 'exception message');
  //     //arrange
  //     when(mockErrorHandlerMiddleware.sendRequest(any))
  //         .thenThrow(tServerException);
  //     final call = assetDetailRemoteDataSourceImpl.getDetail;

  //     //assert
  //     expect(
  //         () => call(params),
  //         throwsA(const TypeMatcher<ServerException>()
  //             .having((e) => e.message, 'message', tServerException.message)));
  //     verify(mockErrorHandlerMiddleware.sendRequest(any));
  //   });
  // });
}
