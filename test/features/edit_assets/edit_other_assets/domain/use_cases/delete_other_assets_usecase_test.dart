import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/data/models/delete_other_assets_params.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/domain/use_cases/delete_other_assets_usecase.dart';

import '../../data/repositories/edit_other_assets_repository_impl_test.mocks.dart';




void main() {
  late DeleteOtherAssetsUseCase deleteOtherAssetsUseCase;
  late MockEditOtherAssetsRepository mockEditOtherAssetsRepository;

  setUp(() {
    mockEditOtherAssetsRepository = MockEditOtherAssetsRepository();
    deleteOtherAssetsUseCase = DeleteOtherAssetsUseCase(mockEditOtherAssetsRepository);
  });

  test('should get DeleteOtherAssetsEntity from the repository', () async {
    //arrange
    when(mockEditOtherAssetsRepository.deleteOtherAssets(any))
        .thenAnswer((_) async => Right(AppSuccess(message: "Successfully done")));
    // act
    final result = await deleteOtherAssetsUseCase(DeleteOtherAssetsParams.tParams);

    // assert
    expect(result, equals(Right(AppSuccess.tAppSuccess)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockEditOtherAssetsRepository.deleteOtherAssets(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await deleteOtherAssetsUseCase(DeleteOtherAssetsParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockEditOtherAssetsRepository.deleteOtherAssets(DeleteOtherAssetsParams.tParams));
    },
  );
}

    