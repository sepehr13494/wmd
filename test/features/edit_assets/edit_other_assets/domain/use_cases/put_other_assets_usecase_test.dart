import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/add_assets/add_other_asset/domain/use_cases/add_other_asset_usecase.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/data/models/put_other_assets_params.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/domain/use_cases/put_other_assets_usecase.dart';

import '../../data/repositories/edit_other_assets_repository_impl_test.mocks.dart';




void main() {
  late PutOtherAssetsUseCase putOtherAssetsUseCase;
  late MockEditOtherAssetsRepository mockEditOtherAssetsRepository;

  setUp(() {
    mockEditOtherAssetsRepository = MockEditOtherAssetsRepository();
    putOtherAssetsUseCase = PutOtherAssetsUseCase(mockEditOtherAssetsRepository);
  });

  test('should get PutOtherAssetsEntity from the repository', () async {
    //arrange
    when(mockEditOtherAssetsRepository.putOtherAssets(any))
        .thenAnswer((_) async => Right(AppSuccess(message: "Successfully done")));
    // act
    final result = await putOtherAssetsUseCase(AddOtherAssetParams.tAddOtherAssetMap,PutOtherAssetsParams.tParams.assetId);

    // assert
    expect(result, equals(Right(AppSuccess.tAppSuccess)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockEditOtherAssetsRepository.putOtherAssets(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await putOtherAssetsUseCase(AddOtherAssetParams.tAddOtherAssetMap,PutOtherAssetsParams.tParams.assetId);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockEditOtherAssetsRepository.putOtherAssets(PutOtherAssetsParams.tParams));
    },
  );
}

    