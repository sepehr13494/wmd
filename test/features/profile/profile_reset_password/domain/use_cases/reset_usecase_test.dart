import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/profile/profile_reset_password/data/models/reset_params.dart';
import 'package:wmd/features/profile/profile_reset_password/data/models/reset_response.dart';
import 'package:wmd/features/profile/profile_reset_password/domain/use_cases/reset_usecase.dart';

import '../../data/repositories/profile_reset_password_repository_impl_test.mocks.dart';




void main() {
  late ResetUseCase resetUseCase;
  late MockProfileResetPasswordRepository mockProfileResetPasswordRepository;

  setUp(() {
    mockProfileResetPasswordRepository = MockProfileResetPasswordRepository();
    resetUseCase = ResetUseCase(mockProfileResetPasswordRepository);
  });

  test('should get ResetEntity from the repository', () async {
    //arrange
    when(mockProfileResetPasswordRepository.reset(any))
        .thenAnswer((_) async => const Right(AppSuccess()));
    // act
    final result = await resetUseCase(ResetParams.tParams);

    // assert
    expect(result, equals(const Right(AppSuccess.tAppSuccess)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockProfileResetPasswordRepository.reset(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await resetUseCase(ResetParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockProfileResetPasswordRepository.reset(ResetParams.tParams));
    },
  );
}

    