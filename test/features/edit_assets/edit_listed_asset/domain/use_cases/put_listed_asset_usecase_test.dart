import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/data/models/put_listed_asset_params.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/domain/use_cases/put_listed_asset_usecase.dart';

import '../../data/repositories/edit_listed_asset_repository_impl_test.mocks.dart';




void main() {
  late PutListedAssetUseCase putListedAssetUseCase;
  late MockEditListedAssetRepository mockEditListedAssetRepository;

  setUp(() {
    mockEditListedAssetRepository = MockEditListedAssetRepository();
    putListedAssetUseCase = PutListedAssetUseCase(mockEditListedAssetRepository);
  });

  test('should get PutListedAssetEntity from the repository', () async {
    //arrange
    when(mockEditListedAssetRepository.putListedAsset(any))
        .thenAnswer((_) async => Right(AppSuccess(message: "Successfully done")));
    // act
    final result = await putListedAssetUseCase(PutListedAssetParams.tParams.addListedSecurityParams.toJson(),PutListedAssetParams.tParams.assetId);

    // assert
    expect(result, equals(Right(AppSuccess.tAppSuccess)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockEditListedAssetRepository.putListedAsset(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await putListedAssetUseCase(PutListedAssetParams.tParams.addListedSecurityParams.toJson(),PutListedAssetParams.tParams.assetId);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockEditListedAssetRepository.putListedAsset(PutListedAssetParams.tParams));
    },
  );
}

    