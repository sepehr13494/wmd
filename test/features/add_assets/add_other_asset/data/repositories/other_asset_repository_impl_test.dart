import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_other_asset/data/data_sources/other_asset_remote_data_source.dart';
import 'package:wmd/features/add_assets/add_other_asset/data/repositories/other_asset_repository_impl.dart';
import 'package:wmd/features/add_assets/add_other_asset/domain/use_cases/add_other_asset_usecase.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';

import 'other_asset_repository_impl_test.mocks.dart';

@GenerateMocks([OtherAssetRemoteDataSource])
void main() {
  late MockOtherAssetRemoteDataSource mockOtherAssetRemoteDataSource;
  late OtherAssetRepositoryImpl otherAssetRepositoryImpl;
  setUp(() {
    mockOtherAssetRemoteDataSource = MockOtherAssetRemoteDataSource();
    otherAssetRepositoryImpl =
        OtherAssetRepositoryImpl(mockOtherAssetRemoteDataSource);
  });

  final tServerException = ServerException(message: 'test server message');

  group('test for postOtherAsset in Other Asset Repository', () {
    test(
      'should return save response data when the call to other asset remote data source is successful',
      () async {
        // arrange
        when(mockOtherAssetRemoteDataSource.postOtherAsset(any))
            .thenAnswer((_) async => AddAssetModel.tAddAssetModel);
        // act
        final result = await otherAssetRepositoryImpl
            .postOtherAsset(AddOtherAssetParams.tAddOtherAssetParams);
        // assert
        verify(mockOtherAssetRemoteDataSource
            .postOtherAsset(AddOtherAssetParams.tAddOtherAssetParams));
        expect(result, equals(const Right(AddAssetModel.tAddAssetModel)));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(mockOtherAssetRemoteDataSource.postOtherAsset(any))
            .thenThrow(tServerException);
        // act
        final result = await otherAssetRepositoryImpl
            .postOtherAsset(AddOtherAssetParams.tAddOtherAssetParams);
        // assert
        verify(mockOtherAssetRemoteDataSource
            .postOtherAsset(AddOtherAssetParams.tAddOtherAssetParams));

        expect(result,
            equals(Left(ServerFailure(message: tServerException.message))));
      },
    );
  });
}
