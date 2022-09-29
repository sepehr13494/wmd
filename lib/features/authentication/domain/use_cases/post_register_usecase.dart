import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/authentication/domain/repositories/auth_repository.dart';

class PostRegisterUseCase extends UseCase<AppSuccess, RegisterParams> {
  final AuthRepository authRepository;

  PostRegisterUseCase(this.authRepository);

  @override
  Future<Either<Failure, AppSuccess>> call(RegisterParams params) =>
      authRepository.register(params);
}

class RegisterParams extends Equatable {
  final String email;
  final String password;

  RegisterParams({
    this.email = "",
    this.password = "",
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };

  factory RegisterParams.fromJson(Map<String, dynamic> json) {
    return RegisterParams(
      email: json['email'],
      password: json['password'],
    );
  }

  @override
  List<Object?> get props => [email, password];
}
