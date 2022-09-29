import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/authentication/domain/use_cases/post_register_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'post_login_usecase_test.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late PostRegisterUseCase postRegisterUseCase;
  late AppSuccess tSuccessForRegister;

  setUp(() {
    tSuccessForRegister = const AppSuccess(message: "Register is successful");
    mockAuthRepository = MockAuthRepository();
    postRegisterUseCase = PostRegisterUseCase(mockAuthRepository);
  });

  final tRegisterParams =
      RegisterParams(email: 'test@yopmail.com', password: 'Passw0rd');

  test(
    'should get App success from the auth repository',
    () async {
      //arrange
      when(mockAuthRepository.register(tRegisterParams))
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
      when(mockAuthRepository.register(tRegisterParams))
          .thenAnswer((_) async => const Left(tServerFailure));
      //act
      final result = await postRegisterUseCase.call(tRegisterParams);
      //assert
      expect(result, const Left(tServerFailure));
    },
  );
}
