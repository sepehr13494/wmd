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
  Future<Either<Failure, AppSuccess>> call(LoginParams params) async {
    return await authRepository.login(params);
  }
}

class LoginParams extends Equatable {
  final String username;
  final String password;

  const LoginParams({
    this.username = "",
    this.password = "",
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
