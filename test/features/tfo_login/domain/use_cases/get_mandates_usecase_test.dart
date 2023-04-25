import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/add_assets/tfo_login/data/models/get_mandates_params.dart';
import 'package:wmd/features/add_assets/tfo_login/domain/use_cases/get_mandates_usecase.dart';

import '../../data/repositories/tfo_login_repository_impl_test.mocks.dart';

void main() {
  late GetMandatesUseCase getMandatesUseCase;
  late MockTfoLoginRepository mockTfoLoginRepository;

  setUp(() {
    mockTfoLoginRepository = MockTfoLoginRepository();
    getMandatesUseCase = GetMandatesUseCase(mockTfoLoginRepository);
  });

  test('should get GetMandatesEntity from the repository', () async {
    //arrange
    when(mockTfoLoginRepository.getMandates(any)).thenAnswer(
        (_) async => Right(AppSuccess(message: "successfully done")));
    // act
    final result = await getMandatesUseCase(GetMandatesParams.tParams);

    // assert
    expect(result, equals(Right(AppSuccess.tAppSuccess)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockTfoLoginRepository.getMandates(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await getMandatesUseCase(GetMandatesParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockTfoLoginRepository.getMandates(GetMandatesParams.tParams));
    },
  );
}
