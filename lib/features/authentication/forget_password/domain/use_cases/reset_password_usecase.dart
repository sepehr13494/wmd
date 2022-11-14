import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/authentication/forget_password/domain/repositories/forget_password_repository.dart';

class ResetPasswordUseCase extends UseCase<AppSuccess, ResetPasswordParams> {
  final ForgetPasswordRepository forgetPasswordRepository;

  ResetPasswordUseCase(this.forgetPasswordRepository);
  @override
  Future<Either<Failure, AppSuccess>> call(ResetPasswordParams params) {
    return forgetPasswordRepository.resetPassword(params);
  }
}

class ResetPasswordParams extends Equatable {
  final String password;
  final String email;
  final String data;
  final String expiryDate;

  const ResetPasswordParams({
    required this.password,
    required this.email,
    required this.data,
    required this.expiryDate,
  });

  factory ResetPasswordParams.fromJson(Map<String, dynamic> json) =>
      ResetPasswordParams(
        password: json["password"],
        email: json["email"],
        data: json["data"],
        expiryDate: json["expiryDate"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "email": email,
        "data": data,
        "expiryDate": expiryDate,
      };

  @override
  List<Object?> get props => [password, email, data, expiryDate];
}
