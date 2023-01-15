import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/asset_detail/bank_account/data/models/bank_account_response.dart';
import 'package:wmd/features/asset_detail/core/data/data_sources/asset_detail_remote_datasource.dart';
import 'package:wmd/features/asset_detail/core/data/models/get_detail_params.dart';
import 'package:wmd/features/asset_detail/core/data/repositories/asset_summary_repository_impl.dart';
import 'package:wmd/features/asset_detail/core/domain/repositories/asset_detail_repository.dart';

import 'asset_detail_repository_impl_test.mocks.dart';

@GenerateMocks([AssetDetailRemoteDataSource, AssetDetailRepository])
void main() {
  late MockAssetDetailRemoteDataSource assetDetailRemoteDataSource;
  late AssetDetailRepository repositoryImpl;

  setUp(() async {
    assetDetailRemoteDataSource = MockAssetDetailRemoteDataSource();
    repositoryImpl = AssetDetailRepositoryImpl(assetDetailRemoteDataSource);
  });

  final tServerException = ServerException(message: 'test server message');

  group('test for getAssetsDetails in AssetsDetailRepository', () {
    GetDetailParams params =
        GetDetailParams(type: 'BankAccount', assetId: 'assetId');
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        final resp = BankAccountResponse.fromJson(
            BankAccountResponse.tBankAccountResponse);
        // arrange
        when(assetDetailRemoteDataSource.getDetail(any))
            .thenAnswer((_) async => resp);
        // act
        final result = await repositoryImpl.getDetail(params);
        // assert
        expect(result, equals(Right(resp)));
        verify(assetDetailRemoteDataSource.getDetail(params));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(assetDetailRemoteDataSource.getDetail(any))
            .thenThrow(tServerException);
        // act
        final result = await repositoryImpl.getDetail(params);
        // assert
        verify(assetDetailRemoteDataSource.getDetail(params));

        expect(result,
            equals(Left(ServerFailure.fromServerException(tServerException))));
      },
    );
  });
}
