import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/authentication/logout/data/models/perform_logout_params.dart';
import 'package:wmd/features/authentication/logout/domain/use_cases/perform_logout_usecase.dart';

import '../../data/repositories/logout_repository_impl_test.mocks.dart';




void main() {
  late PerformLogoutUseCase performLogoutUseCase;
  late MockLogoutRepository mockLogoutRepository;

  setUp(() {
    mockLogoutRepository = MockLogoutRepository();
    performLogoutUseCase = PerformLogoutUseCase(mockLogoutRepository);
  });

  test('should get PerformLogoutEntity from the repository', () async {
    //arrange
    when(mockLogoutRepository.performLogout(any))
        .thenAnswer((_) async => Right(AppSuccess(message: "Successfully done")));
    // act
    final result = await performLogoutUseCase(PerformLogoutParams.tParams);

    // assert
    expect(result, equals(Right(AppSuccess.tAppSuccess)));
  });

  test(
    'should get App Failure from the repository when there is an failure',
    () async {
      //arrange
      when(mockLogoutRepository.performLogout(any))
          .thenAnswer((_) async => const Left(ServerFailure.tServerFailure));
      //act
      final result = await performLogoutUseCase(PerformLogoutParams.tParams);
      //assert
      expect(result, const Left(ServerFailure.tServerFailure));
      verify(mockLogoutRepository.performLogout(PerformLogoutParams.tParams));
    },
  );
}

    