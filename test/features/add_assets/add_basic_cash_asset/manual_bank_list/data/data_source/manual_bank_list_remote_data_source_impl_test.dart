import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/manual_bank_list/data/data_sources/manual_bank_list_remote_datasource.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/manual_bank_list/data/models/get_manual_list_params.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/manual_bank_list/data/models/get_manual_list_response.dart';

import '../../../../../../core/data/network/error_handler_middleware_test.mocks.dart';


Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late ManualBankListRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    remoteDataSourceImpl =
        ManualBankListRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('getManualList', () {
    final tGetManualListOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.getManualList,
      GetManualListParams.tParams.toJson(),
    );
    test('should return GetManualListResponse when API call is successful', () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => List<dynamic>.from(GetManualListResponse.tResponse.map((x) => x.toJson())),
      );
      //act
      final result =
          await remoteDataSourceImpl.getManualList(GetManualListParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware.sendRequest(tGetManualListOptions));
      expect(result, GetManualListResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.getManualList;
      //assert
      expect(
          () => call(GetManualListParams.tParams),
          throwsA(const TypeMatcher<ServerException>()
              .having((e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware.sendRequest(tGetManualListOptions));
    });
    
  });


}
    