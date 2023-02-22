import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/assets_overview/currency_chart/data/data_sources/currency_chart_remote_datasource.dart';
import 'package:wmd/features/assets_overview/currency_chart/data/models/get_currency_params.dart';
import 'package:wmd/features/assets_overview/currency_chart/data/models/get_currency_response.dart';
import 'package:wmd/features/assets_overview/currency_chart/data/repositories/currency_chart_repository_impl.dart';
import 'package:wmd/features/assets_overview/currency_chart/domain/repositories/currency_chart_repository.dart';

import 'currency_chart_repository_impl_test.mocks.dart';


@GenerateMocks([CurrencyChartRemoteDataSource,CurrencyChartRepository])
void main() {
  late MockCurrencyChartRemoteDataSource remoteDataSource;
  late CurrencyChartRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockCurrencyChartRemoteDataSource();
    repositoryImpl = CurrencyChartRepositoryImpl(
        remoteDataSource);
  });

  group('GetCurrency', () {
    test(
      'should return GetCurrencyResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.getCurrency(any))
            .thenAnswer((_) async => GetCurrencyResponse.tResponse);
        // act
        final result = await repositoryImpl.getCurrency(GetCurrencyParams.tParams);
        // assert
        expect(result, equals(Right(GetCurrencyResponse.tResponse)));
        verify(remoteDataSource.getCurrency(GetCurrencyParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.getCurrency(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl.getCurrency(GetCurrencyParams.tParams);
        // assert
        verify(remoteDataSource.getCurrency(GetCurrencyParams.tParams));

        expect(result,
            equals(Left(ServerFailure.fromServerException(ServerException.tServerException))));
      },
    );
    
    test(
      'should return app failure on app exception',
          () async {
        // arrange
        when(remoteDataSource.getCurrency(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl.getCurrency(GetCurrencyParams.tParams);
        // assert
        verify(remoteDataSource.getCurrency(GetCurrencyParams.tParams));

        expect(result,
            equals(Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
    
  });

}
