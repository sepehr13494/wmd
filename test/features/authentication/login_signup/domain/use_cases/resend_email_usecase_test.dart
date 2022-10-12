import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/authentication/login_signup/domain/use_cases/resend_email_usecase.dart';


import '../../data/repositories/login_sign_up_repository_impl_test.mocks.dart';

void main() {
  late MockLoginSignUpRepository mockLoginSignUpRepository;
  late ResendEmailUseCase resendEmailUseCase;
  late AppSuccess tSuccessForRegister;

  setUp(() {
    tSuccessForRegister = const AppSuccess(message: "Register is successful");
    mockLoginSignUpRepository = MockLoginSignUpRepository();
    resendEmailUseCase = ResendEmailUseCase(mockLoginSignUpRepository);
  });

  const tResendEmailParams = ResendEmailParams.tResendEmailParams;

  test(
    'should get App success from the auth repository',
        () async {
      //arrange
      when(mockLoginSignUpRepository.resendEmail(tResendEmailParams))
          .thenAnswer((_) async => Right(tSuccessForRegister));
      //act
      final result = await resendEmailUseCase.call(tResendEmailParams);
      //assert
      expect(result, equals(Right(tSuccessForRegister)));
    },
  );

  test(
    'should get Server Failure from the auth repository when server request fails',
        () async {
      const tServerFailure = ServerFailure(message: 'Server failure');
      //arrange
      when(mockLoginSignUpRepository.resendEmail(tResendEmailParams))
          .thenAnswer((_) async => const Left(tServerFailure));
      //act
      final result = await resendEmailUseCase.call(tResendEmailParams);
      //assert
      expect(result, const Left(tServerFailure));
    },
  );
}
