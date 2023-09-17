import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/currency/data/data_sources/currency_remote_datasource.dart';
import 'package:wmd/features/currency/data/models/get_currency_params.dart';
import 'package:wmd/features/currency/data/models/get_currency_response.dart';
import 'package:wmd/features/currency/data/repositories/currency_repository_impl.dart';
import 'package:wmd/features/currency/domain/repositories/currency_repository.dart';

import 'currency_repository_impl_test.mocks.dart';

@GenerateMocks([CurrencyRemoteDataSource, CurrencyRepository])
void main() {
  late MockCurrencyRemoteDataSource remoteDataSource;
  late CurrencyRepositoryImpl repositoryImpl;

  setUp(() async {
    remoteDataSource = MockCurrencyRemoteDataSource();
    repositoryImpl = CurrencyRepositoryImpl(remoteDataSource);
  });

  group('GetCurrency', () {
    test(
      'should return GetCurrencyResponse when the call to remote data source is successful',
      () async {
        // arrange
        when(remoteDataSource.getCurrency(any))
            .thenAnswer((_) async => GetCurrencyConversionResponse.tResponse);
        // act
        final result = await repositoryImpl
            .getCurrency(GetCurrencyConversionParams.tParams);
        // assert
        expect(result, equals(Right(GetCurrencyConversionResponse.tResponse)));
        verify(
            remoteDataSource.getCurrency(GetCurrencyConversionParams.tParams));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(remoteDataSource.getCurrency(any))
            .thenThrow(ServerException.tServerException);
        // act
        final result = await repositoryImpl
            .getCurrency(GetCurrencyConversionParams.tParams);
        // assert
        verify(
            remoteDataSource.getCurrency(GetCurrencyConversionParams.tParams));

        expect(
            result,
            equals(Left(ServerFailure.fromServerException(
                ServerException.tServerException))));
      },
    );

    test(
      'should return app failure on app exception',
      () async {
        // arrange
        when(remoteDataSource.getCurrency(any))
            .thenThrow(AppException.tAppException);
        // act
        final result = await repositoryImpl
            .getCurrency(GetCurrencyConversionParams.tParams);
        // assert
        verify(
            remoteDataSource.getCurrency(GetCurrencyConversionParams.tParams));

        expect(
            result,
            equals(
                Left(AppFailure.fromAppException(AppException.tAppException))));
      },
    );
  });
}
