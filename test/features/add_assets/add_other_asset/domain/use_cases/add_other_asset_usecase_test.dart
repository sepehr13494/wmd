import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_other_asset/domain/repositories/other_asset_repository.dart';
import 'package:wmd/features/add_assets/add_other_asset/domain/use_cases/add_other_asset_usecase.dart';
import 'package:wmd/features/add_assets/core/data/models/add_asset_model.dart';

import 'add_other_asset_usecase_test.mocks.dart';

@GenerateMocks([OtherAssetRepository])
void main() {
  late MockOtherAssetRepository mockOtherAssetRepository;
  late AddOtherAssetUseCase addOtherAssetUseCase;

  setUp(() {
    mockOtherAssetRepository = MockOtherAssetRepository();
    addOtherAssetUseCase = AddOtherAssetUseCase(mockOtherAssetRepository);
  });

  final tAddOtherAssetResponse =
      AddAssetModel.fromJson(AddAssetModel.tAddAssetResponse);

  test(
    'should get AddAssetModal from other asset repository',
    () async {
      // arrange
      when(mockOtherAssetRepository
              .postOtherAsset(AddOtherAssetParams.tAddOtherAssetParams))
          .thenAnswer((_) async => Right(tAddOtherAssetResponse));

      // act
      final result =
          await addOtherAssetUseCase(AddOtherAssetParams.tAddOtherAssetMap);
      // assert
      expect(result, Right(tAddOtherAssetResponse));
    },
  );

  test(
    'should get ServerFailure from the other asset repository when server request fails',
    () async {
      const tServerFailure = ServerFailure(message: 'Server failure');
      // arrange
      when(mockOtherAssetRepository
              .postOtherAsset(AddOtherAssetParams.tAddOtherAssetParams))
          .thenAnswer((_) async => const Left(tServerFailure));

      // act
      final result =
          await addOtherAssetUseCase(AddOtherAssetParams.tAddOtherAssetMap);
      // assert
      expect(result, const Left(tServerFailure));
    },
  );
}
