import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_private_debt/data/data_sources/private_debt_save_remote_data_source.dart';
import 'package:wmd/features/add_assets/add_private_debt/data/repositories/private_debt_repository_impl.dart';
import 'package:wmd/features/add_assets/add_private_debt/domain/use_cases/add_private_debt_usecase.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';

import 'private_debt_repository_impl_test.mocks.dart';

@GenerateMocks([PrivateDebtSaveRemoteDataSource])
void main() {
  late MockPrivateDebtSaveRemoteDataSource mockPrivateDebtSaveRemoteDataSource;
  late PrivateDebtRepositoryImpl privateDebtRepositoryImpl;
  setUp(() {
    mockPrivateDebtSaveRemoteDataSource = MockPrivateDebtSaveRemoteDataSource();
    privateDebtRepositoryImpl =
        PrivateDebtRepositoryImpl(mockPrivateDebtSaveRemoteDataSource);
  });

  final tServerException = ServerException(message: 'test server message');

  group('test for postPrivateDebt in Private Debt Repository', () {
    test(
      'should return save response data when the call to private debt remote data source is successful',
      () async {
        // arrange
        when(mockPrivateDebtSaveRemoteDataSource.postPrivateDebt(any))
            .thenAnswer((_) async => AddAssetModel.tAddAssetModel);
        // act
        final result = await privateDebtRepositoryImpl
            .postPrivateDebt(AddPrivateDebtParams.tAddPrivateDebtParams);
        // assert
        verify(mockPrivateDebtSaveRemoteDataSource
            .postPrivateDebt(AddPrivateDebtParams.tAddPrivateDebtParams));
        expect(result, equals(const Right(AddAssetModel.tAddAssetModel)));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(mockPrivateDebtSaveRemoteDataSource.postPrivateDebt(any))
            .thenThrow(tServerException);
        // act
        final result = await privateDebtRepositoryImpl
            .postPrivateDebt(AddPrivateDebtParams.tAddPrivateDebtParams);
        // assert
        verify(mockPrivateDebtSaveRemoteDataSource
            .postPrivateDebt(AddPrivateDebtParams.tAddPrivateDebtParams));

        expect(result,
            equals(Left(ServerFailure(message: tServerException.message))));
      },
    );
  });
}
