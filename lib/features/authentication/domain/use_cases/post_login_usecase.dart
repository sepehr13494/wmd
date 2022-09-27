import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/domain/usecases/usercase.dart';
import '../../../../core/error_and_success/failures.dart';
import '../../../../core/error_and_success/succeses.dart';
import '../repositories/auth_repository.dart';

class PostLoginUseCase extends UseCase<AppSuccess, LoginParams> {
  final AuthRepository authRepository;

  PostLoginUseCase(this.authRepository);

  @override
  Future<Either<Failure, AppSuccess>> call(LoginParams params) =>
      authRepository.login(params);
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  LoginParams({
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
