import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/data/models/delete_real_estate_params.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/domain/use_cases/delete_real_estate_usecase.dart';

import '../../data/repositories/edit_real_estate_repository_impl_test.mocks.dart';




void main() {
  late DeleteRealEstateUseCase deleteRealEstateUseCase;
  late MockEditRealEstateRepository mockEditRealEstateRepository;

  setUp(() {
    mockEditRealEstateRepository = MockEditRealEstateRepository();
    deleteRealEstateUseCase = DeleteRealEstateUseCase(mockEditRealEstateRepository);
  });

  test('should get DeleteRealEstateEntity from the repository', () async {
    //arrange
    when(mockEditRealEstateRepository.deleteRealEstate(any))
        .thenAnswer((_) async => const Right(AppSuccess(message: "Successfully done")));
    // act
    final result = await deleteRealEstateUseCase(DeleteRealEstateParams.tParams);

    // assert
    expect(result, equals(const Right(AppSuccess.tAppSuccess)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockEditRealEstateRepository.deleteRealEstate(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await deleteRealEstateUseCase(DeleteRealEstateParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockEditRealEstateRepository.deleteRealEstate(DeleteRealEstateParams.tParams));
    },
  );
}

    