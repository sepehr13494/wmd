import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/data_sources/custodian_bank_auth_remote_datasource.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/custodian_bank_response.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/get_custodian_bank_list_params.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/get_custodian_bank_status_params.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/get_custodian_bank_status_response.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/repositories/custodian_bank_auth_repository_impl.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/get_custodian_bank_status_entity.dart';

import 'custodian_bank_auth_repository_impl_test.mocks.dart';

@GenerateMocks([CustodianBankAuthRemoteDataSource])
void main() {
  late MockCustodianBankAuthRemoteDataSource
      mockCustodianBankAuthRemoteDataSource;
  late CustodianBankAuthRepositoryImpl custodianBankAuthRepositoryImpl;
  setUp(() {
    mockCustodianBankAuthRemoteDataSource =
        MockCustodianBankAuthRemoteDataSource();
    custodianBankAuthRepositoryImpl =
        CustodianBankAuthRepositoryImpl(mockCustodianBankAuthRemoteDataSource);
  });

  final tServerException = ServerException(message: 'test server message');

  group('test for repository to getCustodianBankList', () {
    test(
      'should return bank responses data',
      () async {
        final list = List.generate(
            3,
            (index) => CustodianBankResponse.fromJson(
                CustodianBankResponse.tResponse));
        // arrange
        when(mockCustodianBankAuthRemoteDataSource.getCustodianBankList(any))
            .thenAnswer((_) async => list);
        // act
        final result = await custodianBankAuthRepositoryImpl
            .getCustodianBankList(GetCustodianBankListParams());
        // assert
        verify(mockCustodianBankAuthRemoteDataSource
            .getCustodianBankList(GetCustodianBankListParams()));
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
        when(mockCustodianBankAuthRemoteDataSource.getCustodianBankList(any))
            .thenThrow(tServerException);
        // act
        final result = await custodianBankAuthRepositoryImpl
            .getCustodianBankList(GetCustodianBankListParams());
        // assert
        verify(mockCustodianBankAuthRemoteDataSource
            .getCustodianBankList(GetCustodianBankListParams()));

        expect(result,
            equals(Left(ServerFailure(message: tServerException.message))));
      },
    );
  });
  group('test for repository to getCustodianBankStatus', () {
    final resp = GetCustodianBankStatusResponse.fromJson(
        CustodianBankStatusEntity.tResponse);
    test(
      'should return bank status responses data ',
      () async {
        // arrange
        when(mockCustodianBankAuthRemoteDataSource.getCustodianBankStatus(any))
            .thenAnswer((_) async => resp);
        // act
        final result =
            await custodianBankAuthRepositoryImpl.getCustodianBankStatus(
                GetCustodianBankStatusParams(bankId: resp.bankId));
        // assert
        verify(mockCustodianBankAuthRemoteDataSource.getCustodianBankStatus(
            GetCustodianBankStatusParams(bankId: resp.bankId)));
        expect(
          result,
          equals(Right(resp)),
        );
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(mockCustodianBankAuthRemoteDataSource.getCustodianBankStatus(any))
            .thenThrow(tServerException);
        // act
        final result =
            await custodianBankAuthRepositoryImpl.getCustodianBankStatus(
                GetCustodianBankStatusParams(bankId: resp.bankId));
        // assert
        verify(mockCustodianBankAuthRemoteDataSource.getCustodianBankStatus(
            GetCustodianBankStatusParams(bankId: resp.bankId)));

        expect(result,
            equals(Left(ServerFailure(message: tServerException.message))));
      },
    );
  });
}
