import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/data/data_sources/edit_bank_manual_remote_datasource.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/data/models/delete_bank_manual_params.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/data/models/delete_bank_manual_response.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/data/models/put_bank_manual_params.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/data/models/put_bank_manual_response.dart';

import '../../../../../core/data/network/error_handler_middleware_test.mocks.dart';


Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late EditBankManualRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    remoteDataSourceImpl =
        EditBankManualRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('putBankManual', () {
    final tPutBankManualOptions = AppRequestOptions(
      RequestTypes.put,
      AppUrls.putBankManual,
      PutBankManualParams.tParams.toServerJson(),
    );
    test('should return PutBankManualResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => PutBankManualResponse.tResponse.toJson(),
      );
      //act
      final result =
          await remoteDataSourceImpl.putBankManual(PutBankManualParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tPutBankManualOptions));
      expect(result, PutBankManualResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.putBankManual;
      //assert
      expect(
          () => call(PutBankManualParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tPutBankManualOptions));
    });
    
  });
  group('deleteBankManual', () {
    final tDeleteBankManualOptions = AppRequestOptions(
      RequestTypes.del,
      AppUrls.deleteBankManual,
      DeleteBankManualParams.tParams.toJson(),
    );
    test('should return DeleteBankManualResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => DeleteBankManualResponse.tResponse.toJson(),
      );
      //act
      final result =
          await remoteDataSourceImpl.deleteBankManual(DeleteBankManualParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tDeleteBankManualOptions));
      expect(result, DeleteBankManualResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.deleteBankManual;
      //assert
      expect(
          () => call(DeleteBankManualParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tDeleteBankManualOptions));
    });
    
  });


}
    