import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:wmd/features/add_assets/add_basic_cash_asset/data/data_sources/bank_details_save_remote_data_source.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/data/models/bank_save_response_model.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/data/repositories/bank_repository_impl.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/entities/bank_save_response.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/use_cases/post_bank_details_usecase.dart';

import 'bank_repository_impl_test.mocks.dart';

@GenerateMocks([BankSaveRemoteDataSource])
void main() {
  late MockBankSaveRemoteDataSource mockBankSaveRemoteDataSource;
  late BankRepositoryImpl bankRepositoryImpl;
  setUp(() {
    mockBankSaveRemoteDataSource = MockBankSaveRemoteDataSource();
    bankRepositoryImpl = BankRepositoryImpl(mockBankSaveRemoteDataSource);
  });

  final tServerException = ServerException(message: 'test server message');

  group('test for postBankDetails in BankRepository', () {
    test(
      'should return bank save response data when the call to bank remote data source is successful',
      () async {
        // arrange
        when(mockBankSaveRemoteDataSource.postBankDetails(any)).thenAnswer(
            (_) async => BankSaveResponseModel.tBankSaveResponseModel);
        // act
        final result = await bankRepositoryImpl
            .postBankDetails(BankSaveParams.tBankSaveParams);
        // assert
        verify(mockBankSaveRemoteDataSource
            .postBankDetails(BankSaveParams.tBankSaveParams));
        expect(result,
            equals(const Right(BankSaveResponseModel.tBankSaveResponseModel)));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(mockBankSaveRemoteDataSource.postBankDetails(any))
            .thenThrow(tServerException);
        // act
        final result = await bankRepositoryImpl
            .postBankDetails(BankSaveParams.tBankSaveParams);
        // assert
        verify(mockBankSaveRemoteDataSource
            .postBankDetails(BankSaveParams.tBankSaveParams));

        expect(result,
            equals(Left(ServerFailure(message: tServerException.message))));
      },
    );
  });
}
