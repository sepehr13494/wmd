import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wmd/features/authentication/login_signup/domain/use_cases/post_register_usecase.dart';

import '../../data/repositories/login_sign_up_repository_impl_test.mocks.dart';


void main() {
  late MockLoginSignUpRepository mockLoginSignUpRepository;
  late PostRegisterUseCase postRegisterUseCase;
  late AppSuccess tSuccessForRegister;

  setUp(() {
    tSuccessForRegister = const AppSuccess(message: "Register is successful");
    mockLoginSignUpRepository = MockLoginSignUpRepository();
    postRegisterUseCase = PostRegisterUseCase(mockLoginSignUpRepository);
  });

  final tRegisterParams =
      RegisterParams(email: 'test@yopmail.com', password: 'Passw0rd');

  test(
    'should get App success from the auth repository',
    () async {
      //arrange
      when(mockLoginSignUpRepository.register(tRegisterParams))
          .thenAnswer((_) async => Right(tSuccessForRegister));
      //act
      final result = await postRegisterUseCase.call(tRegisterParams);
      //assert
      expect(result, equals(Right(tSuccessForRegister)));
    },
  );

  test(
    'should get Server Failure from the auth repository when server request fails',
    () async {
      const tServerFailure = ServerFailure(message: 'Server failure');
      //arrange
      when(mockLoginSignUpRepository.register(tRegisterParams))
          .thenAnswer((_) async => const Left(tServerFailure));
      //act
      final result = await postRegisterUseCase.call(tRegisterParams);
      //assert
      expect(result, const Left(tServerFailure));
    },
  );
}
