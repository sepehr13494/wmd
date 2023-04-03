import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/data/models/put_real_estate_params.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/domain/use_cases/put_real_estate_usecase.dart';

import '../../data/repositories/edit_real_estate_repository_impl_test.mocks.dart';




void main() {
  late PutRealEstateUseCase putRealEstateUseCase;
  late MockEditRealEstateRepository mockEditRealEstateRepository;

  setUp(() {
    mockEditRealEstateRepository = MockEditRealEstateRepository();
    putRealEstateUseCase = PutRealEstateUseCase(mockEditRealEstateRepository);
  });

  test('should get PutRealEstateEntity from the repository', () async {
    //arrange
    when(mockEditRealEstateRepository.putRealEstate(any))
        .thenAnswer((_) async => const Right(AppSuccess(message: "successfully done")));
    // act
    final result = await putRealEstateUseCase(PutRealEstateParams.tParams);

    // assert
    expect(result, equals(const Right(AppSuccess.tAppSuccess)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockEditRealEstateRepository.putRealEstate(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await putRealEstateUseCase(PutRealEstateParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockEditRealEstateRepository.putRealEstate(PutRealEstateParams.tParams));
    },
  );
}

    