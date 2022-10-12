/*
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/authentication/domain/repositories/login_sign_up_repository.dart';

class GoogleLoginUseCase extends UseCase<AppSuccess, GoogleLoginParams> {
  final AuthRepository authRepository;

  GoogleLoginUseCase(this.authRepository);

  @override
  Future<Either<Failure, AppSuccess>> call(GoogleLoginParams params) async {
    return await authRepository.googleLogin(params);
  }
}

class GoogleLoginParams extends Equatable {

  const GoogleLoginParams();

  Map<String, dynamic> toJson() => {

  };

  factory GoogleLoginParams.fromJson(Map<String, dynamic> json) {
    return const GoogleLoginParams();
  }

  @override
  List<Object?> get props => [];
}
*/
