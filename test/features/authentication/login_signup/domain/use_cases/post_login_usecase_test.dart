import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wmd/features/authentication/login_signup/domain/use_cases/post_login_usecase.dart';

import '../../data/repositories/login_sign_up_repository_impl_test.mocks.dart';

void main() {
  late MockLoginSignUpRepository mockLoginSignUpRepository;
  late PostLoginUseCase postLoginUseCase;
  // late Login loginEntity;
  late AppSuccess tSuccessForLogin;

  setUp(() {
    tSuccessForLogin = const AppSuccess(message: "Login is successful");
    mockLoginSignUpRepository = MockLoginSignUpRepository();
    postLoginUseCase = PostLoginUseCase(mockLoginSignUpRepository);
  });

  final tLoginParams =
      LoginParams(username: 'test@yopmail.com', password: 'Passw0rd');

  test(
    'should get login entity from the auth repository',
    () async {
      //arrange
      when(mockLoginSignUpRepository.login(tLoginParams))
          .thenAnswer((_) async => Right(tSuccessForLogin));
      //act
      final result = await postLoginUseCase.call(tLoginParams);
      //assert
      expect(result, equals(Right(tSuccessForLogin)));
    },
  );

  test(
    'should get Server Failure from the auth repository when server request fails',
    () async {
      const tServerFailure = ServerFailure(message: 'Server failure');
      //arrange
      when(mockLoginSignUpRepository.login(tLoginParams))
          .thenAnswer((_) async => const Left(tServerFailure));
      //act
      final result = await postLoginUseCase.call(tLoginParams);
      //assert
      expect(result, const Left(tServerFailure));
    },
  );
}
