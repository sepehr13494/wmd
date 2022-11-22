import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_real_estate/data/data_sources/real_estate_remote_data_source.dart';
import 'package:wmd/features/add_assets/add_real_estate/data/repositories/real_estate_repository_impl.dart';
import 'package:wmd/features/add_assets/add_real_estate/domain/use_cases/add_real_estate_usecase.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';

import 'real_estate_repository_impl_test.mocks.dart';

@GenerateMocks([RealEstateRemoteDataSource])
void main() {
  late MockRealEstateRemoteDataSource mockRealEstateRemoteDataSource;
  late RealEstateRepositoryImpl realEstateRepositoryImpl;
  setUp(() {
    mockRealEstateRemoteDataSource = MockRealEstateRemoteDataSource();
    realEstateRepositoryImpl =
        RealEstateRepositoryImpl(mockRealEstateRemoteDataSource);
  });

  final tServerException = ServerException(message: 'test server message');

  group('test for postPrivateDebt in Real Estate Repository', () {
    test(
      'should return save response data when the call to real estate remote data source is successful',
      () async {
        // arrange
        when(mockRealEstateRemoteDataSource.postRealEstate(any))
            .thenAnswer((_) async => AddAssetModel.tAddAssetModel);
        // act
        final result = await realEstateRepositoryImpl
            .postRealEstate(AddRealEstateParams.tAddRealEstateParams);
        // assert
        verify(mockRealEstateRemoteDataSource
            .postRealEstate(AddRealEstateParams.tAddRealEstateParams));
        expect(result, equals(const Right(AddAssetModel.tAddAssetModel)));
      },
    );

    test(
      'should return server failure on server exception',
      () async {
        // arrange
        when(mockRealEstateRemoteDataSource.postRealEstate(any))
            .thenThrow(tServerException);
        // act
        final result = await realEstateRepositoryImpl
            .postRealEstate(AddRealEstateParams.tAddRealEstateParams);
        // assert
        verify(mockRealEstateRemoteDataSource
            .postRealEstate(AddRealEstateParams.tAddRealEstateParams));

        expect(result,
            equals(Left(ServerFailure(message: tServerException.message))));
      },
    );
  });
}
