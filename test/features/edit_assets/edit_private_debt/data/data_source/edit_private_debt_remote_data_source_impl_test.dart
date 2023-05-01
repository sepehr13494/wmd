import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/data/data_sources/edit_private_debt_remote_datasource.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/data/models/delete_private_debt_params.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/data/models/delete_private_debt_response.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/data/models/put_private_debt_params.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/data/models/put_private_debt_response.dart';

import '../../../../../core/data/network/error_handler_middleware_test.mocks.dart';


Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late EditPrivateDebtRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    remoteDataSourceImpl =
        EditPrivateDebtRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('putPrivateDebt', () {
    final tPutPrivateDebtOptions = AppRequestOptions(
      RequestTypes.put,
      AppUrls.putPrivateDebt,
      PutPrivateDebtParams.tParams.toServerJson(),
    );
    test('should return PutPrivateDebtResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => PutPrivateDebtResponse.tResponse.toJson(),
      );
      //act
      final result =
          await remoteDataSourceImpl.putPrivateDebt(PutPrivateDebtParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tPutPrivateDebtOptions));
      expect(result, PutPrivateDebtResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.putPrivateDebt;
      //assert
      expect(
          () => call(PutPrivateDebtParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tPutPrivateDebtOptions));
    });
    
  });
  group('deletePrivateDebt', () {
    final tDeletePrivateDebtOptions = AppRequestOptions(
      RequestTypes.del,
      AppUrls.deletePrivateDebt,
      DeletePrivateDebtParams.tParams.toJson(),
    );
    test('should return DeletePrivateDebtResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => DeletePrivateDebtResponse.tResponse.toJson(),
      );
      //act
      final result =
          await remoteDataSourceImpl.deletePrivateDebt(DeletePrivateDebtParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tDeletePrivateDebtOptions));
      expect(result, DeletePrivateDebtResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.deletePrivateDebt;
      //assert
      expect(
          () => call(DeletePrivateDebtParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tDeletePrivateDebtOptions));
    });
    
  });


}
    