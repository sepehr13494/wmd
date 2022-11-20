import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_bank_auto/data/data_sources/bank_list_data_source.dart';
import 'package:wmd/features/add_assets/add_bank_auto/data/models/bank_list_response.dart';
import 'package:wmd/features/add_assets/add_bank_auto/data/repository/bank_list_repository_impl.dart';

import 'bank_list_repository_impl_test.mocks.dart';

@GenerateMocks([BankListRemoteDataSource])
void main() {
  late MockBankListRemoteDataSource mockBankListRemoteDataSource;
  late BankListRepositoryImpl bankListRepositoryImpl;
  setUp(() {
    mockBankListRemoteDataSource = MockBankListRemoteDataSource();
    bankListRepositoryImpl =
        BankListRepositoryImpl(mockBankListRemoteDataSource);
  });

  final tServerException = ServerException(message: 'test server message');

  group('test for getBankList in BankListRepository', () {
    test(
      'should return bank response data when the call to bank list remote data source is successful',
      () async {
        final list = List.generate(
            3, (index) => BankResponse.fromJson(BankResponse.tBankResponse));
        // arrange
        when(mockBankListRemoteDataSource.getBankList(any))
            .thenAnswer((_) async => list);
        // act
        final result = await bankListRepositoryImpl.getBankList(NoParams());
        // assert
        verify(mockBankListRemoteDataSource.getBankList(NoParams()));
        expect(
          result,
          equals(Right(list)),
        );
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(mockBankListRemoteDataSource.getBankList(any))
            .thenThrow(tServerException);
        // act
        final result = await bankListRepositoryImpl.getBankList(NoParams());
        // assert
        verify(mockBankListRemoteDataSource.getBankList(NoParams()));

        expect(result,
            equals(Left(ServerFailure(message: tServerException.message))));
      },
    );
  });
  group('test for getPopularBankList in BankListRepository', () {
    test(
      'should return bank response data when the call to bank list remote data source is successful',
      () async {
        final list = List.generate(
            3, (index) => BankResponse.fromJson(BankResponse.tBankResponse));
        // arrange
        when(mockBankListRemoteDataSource.getPopularBankList(any))
            .thenAnswer((_) async => list);
        // act
        final result = await bankListRepositoryImpl.getPopularBankList(3);
        // assert
        verify(mockBankListRemoteDataSource.getPopularBankList(3));
        expect(
          result,
          equals(Right(list)),
        );
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(mockBankListRemoteDataSource.getPopularBankList(any))
            .thenThrow(tServerException);
        // act
        final result = await bankListRepositoryImpl.getPopularBankList(3);
        // assert
        verify(mockBankListRemoteDataSource.getPopularBankList(3));

        expect(result,
            equals(Left(ServerFailure(message: tServerException.message))));
      },
    );
  });
}
