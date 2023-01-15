import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import '../repositories/login_sign_up_repository.dart';

class PostLoginUseCase extends UseCase<AppSuccess, LoginParams> {
  final LoginSignUpRepository loginSignUpRepository;

  PostLoginUseCase(this.loginSignUpRepository);

  @override
  Future<Either<Failure, AppSuccess>> call(LoginParams params) async {
    return await loginSignUpRepository.login(params);
  }
}

class LoginParams extends Equatable {
  final String username;
  final String password;

  const LoginParams({
    this.username = ".",
    this.password = ".",
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };

  factory LoginParams.fromJson(Map<String, dynamic> json) {
    return LoginParams(
      username: json['username'],
      password: json['password'],
    );
  }

  @override
  List<Object?> get props => [username, password];
}
