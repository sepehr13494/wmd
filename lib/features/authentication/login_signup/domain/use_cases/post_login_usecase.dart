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
  final String email;
  final String password;

  const LoginParams({
    this.email = "",
    this.password = "",
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };

  factory LoginParams.fromJson(Map<String, dynamic> json) {
    return LoginParams(
      email: json['email'],
      password: json['password'],
    );
  }

  @override
  List<Object?> get props => [email,password];
}
