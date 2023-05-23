import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/data/network/server_request_manager.dart';
import 'package:wmd/core/data/network/urls.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/models/app_request_options.dart';
import 'package:wmd/features/liability_overview/data/data_sources/liablility_overview_remote_datasource.dart';
import 'package:wmd/features/liability_overview/data/models/get_liablility_overview_params.dart';
import 'package:wmd/features/liability_overview/data/models/get_liablility_overview_response.dart';

import '../../../../core/data/network/error_handler_middleware_test.mocks.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  late MockErrorHandlerMiddleware mockErrorHandlerMiddleware;
  late LiabilityOverviewRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockErrorHandlerMiddleware = MockErrorHandlerMiddleware();
    remoteDataSourceImpl =
        LiabilityOverviewRemoteDataSourceImpl(mockErrorHandlerMiddleware);
  });

  group('getLiablilityOverview', () {
    final tGetLiablilityOverviewOptions = AppRequestOptions(
      RequestTypes.get,
      AppUrls.getLiablilityOverview,
      GetLiabilityOverviewParams.tParams.toJson(),
    );
    test(
        'should return GetLiablilityOverviewResponse when API call is successful',
        () async {
      // arrange
      when(mockErrorHandlerMiddleware.sendRequest(any)).thenAnswer(
        (_) async => List<dynamic>.from(
            GetLiabilityOverviewResponse.tResponse.map((x) => x.toJson())),
      );
      //act
      final result = await remoteDataSourceImpl
          .getLiablilityOverview(GetLiabilityOverviewParams.tParams);
      //assert
      verify(mockErrorHandlerMiddleware
          .sendRequest(tGetLiablilityOverviewOptions));
      expect(result, GetLiabilityOverviewResponse.tResponse);
    });

    test('should throws ServerException when API call is not successful',
        () async {
      //arrange
      when(mockErrorHandlerMiddleware.sendRequest(any))
          .thenThrow(ServerException.tServerException);
      //act
      final call = remoteDataSourceImpl.getLiablilityOverview;
      //assert
      expect(
          () => call(GetLiabilityOverviewParams.tParams),
          throwsA(const TypeMatcher<ServerException>().having(
              (e) => e.data, 'data', ServerException.tServerException.data)));
      verify(mockErrorHandlerMiddleware
          .sendRequest(tGetLiablilityOverviewOptions));
    });
  });
}
