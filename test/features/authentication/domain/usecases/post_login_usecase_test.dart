import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/authentication/data/models/login_response_model.dart';
import 'package:wmd/features/authentication/domain/repositories/auth_repository.dart';
import 'package:wmd/features/authentication/usecases/post_login_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'post_login_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository mockAuthRepository;
  late PostLogin postLoginUseCase;
  // late Login loginEntity;
  late AppSuccess tSuccessForLogin;

  setUp(() {
    // loginEntity =
    //     LoginModel.fromJson(jsonDecode(fixture('login_success_response.json')));
    tSuccessForLogin = const AppSuccess(message: "Login is successful");
    mockAuthRepository = MockAuthRepository();
    postLoginUseCase = PostLogin(mockAuthRepository);
  });

  final tLoginParams =
      LoginParams(email: 'test@yopmail.com', password: 'Passw0rd');

  test(
    'should get login entity from the auth repository',
    () async {
      //arrange
      when(mockAuthRepository.login(tLoginParams))
          .thenAnswer((_) async => Right(tSuccessForLogin));
      //act
      final result = await postLoginUseCase.call(tLoginParams);
      //assert
      expect(result, equals(Right(tSuccessForLogin)));
    },
  );
}
