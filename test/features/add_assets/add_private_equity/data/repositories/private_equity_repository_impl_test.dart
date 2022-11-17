import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_private_equity/data/data_sources/private_equity_remote_data_source.dart';
import 'package:wmd/features/add_assets/add_private_equity/data/repositories/private_equity_repository_impl.dart';
import 'package:wmd/features/add_assets/add_private_equity/domain/use_cases/add_private_equity_usecase.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';

import 'private_equity_repository_impl_test.mocks.dart';

@GenerateMocks([PrivateEquityRemoteDataSource])
void main() {
  late MockPrivateEquityRemoteDataSource mockPrivateEquityRemoteDataSource;
  late PrivateEquityRepositoryImpl privateEquityRepositoryImpl;
  setUp(() {
    mockPrivateEquityRemoteDataSource = MockPrivateEquityRemoteDataSource();
    privateEquityRepositoryImpl =
        PrivateEquityRepositoryImpl(mockPrivateEquityRemoteDataSource);
  });

  final tServerException = ServerException(message: 'test server message');

  group('test for postPrivateEquity in BankRepository', () {
    test(
      'should return bank save response data when the call to bank remote data source is successful',
      () async {
        // arrange
        when(mockPrivateEquityRemoteDataSource.postPrivateEquityDetails(any))
            .thenAnswer((_) async => AddAssetModel.tAddAssetModel);
        // act
        final result = await privateEquityRepositoryImpl
            .postPrivateEquity(AddPrivateEquityParams.tAddPrivateEquityParams);
        // assert
        verify(mockPrivateEquityRemoteDataSource.postPrivateEquityDetails(
            AddPrivateEquityParams.tAddPrivateEquityParams));
        expect(result, equals(const Right(AddAssetModel.tAddAssetModel)));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(mockPrivateEquityRemoteDataSource.postPrivateEquityDetails(any))
            .thenThrow(tServerException);
        // act
        final result = await privateEquityRepositoryImpl
            .postPrivateEquity(AddPrivateEquityParams.tAddPrivateEquityParams);
        // assert
        verify(mockPrivateEquityRemoteDataSource.postPrivateEquityDetails(
            AddPrivateEquityParams.tAddPrivateEquityParams));

        expect(result,
            equals(Left(ServerFailure(message: tServerException.message))));
      },
    );
  });
}
