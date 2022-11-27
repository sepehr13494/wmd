import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_real_estate/domain/repositories/real_estate_repository.dart';
import 'package:wmd/features/add_assets/add_real_estate/domain/use_cases/add_real_estate_usecase.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';

import 'add_real_estate_usecase_test.mocks.dart';

@GenerateMocks([RealEstateRepository])
void main() {
  late MockRealEstateRepository mockRealEstateRepository;
  late AddRealEstateUseCase addRealEstateUseCase;

  setUp(() {
    mockRealEstateRepository = MockRealEstateRepository();
    addRealEstateUseCase = AddRealEstateUseCase(mockRealEstateRepository);
  });

  final tAddRealEstateResponse =
      AddAssetModel.fromJson(AddAssetModel.tAddAssetResponse);

  test(
    'should get AddAssetModal from real estate repository',
    () async {
      // arrange
      when(mockRealEstateRepository
              .postRealEstate(AddRealEstateParams.tAddRealEstateParams))
          .thenAnswer((_) async => Right(tAddRealEstateResponse));

      // act
      final result =
          await addRealEstateUseCase(AddRealEstateParams.tAddRealEstateMap);
      // assert
      expect(result, Right(tAddRealEstateResponse));
    },
  );

  test(
    'should get ServerFailure from the real estate repository when server request fails',
    () async {
      const tServerFailure = ServerFailure(message: 'Server failure');
      // arrange
      when(mockRealEstateRepository
              .postRealEstate(AddRealEstateParams.tAddRealEstateParams))
          .thenAnswer((_) async => const Left(tServerFailure));

      // act
      final result =
          await addRealEstateUseCase(AddRealEstateParams.tAddRealEstateMap);
      // assert
      expect(result, const Left(tServerFailure));
    },
  );
}
