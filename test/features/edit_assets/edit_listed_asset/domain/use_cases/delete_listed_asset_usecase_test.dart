import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/data/models/delete_listed_asset_params.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/domain/use_cases/delete_listed_asset_usecase.dart';

import '../../data/repositories/edit_listed_asset_repository_impl_test.mocks.dart';




void main() {
  late DeleteListedAssetUseCase deleteListedAssetUseCase;
  late MockEditListedAssetRepository mockEditListedAssetRepository;

  setUp(() {
    mockEditListedAssetRepository = MockEditListedAssetRepository();
    deleteListedAssetUseCase = DeleteListedAssetUseCase(mockEditListedAssetRepository);
  });

  test('should get DeleteListedAssetEntity from the repository', () async {
    //arrange
    when(mockEditListedAssetRepository.deleteListedAsset(any))
        .thenAnswer((_) async => Right(AppSuccess(message: "Successfully done")));
    // act
    final result = await deleteListedAssetUseCase(DeleteListedAssetParams.tParams);

    // assert
    expect(result, equals(Right(AppSuccess.tAppSuccess)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockEditListedAssetRepository.deleteListedAsset(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await deleteListedAssetUseCase(DeleteListedAssetParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockEditListedAssetRepository.deleteListedAsset(DeleteListedAssetParams.tParams));
    },
  );
}

    