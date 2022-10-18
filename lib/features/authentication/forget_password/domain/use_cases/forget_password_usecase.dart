import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/authentication/forget_password/domain/repositories/forget_password_repository.dart';

class ForgetPasswordUseCase extends UseCase<AppSuccess,ForgetPasswordParams>{
  final ForgetPasswordRepository forgetPasswordRepository;

  ForgetPasswordUseCase(this.forgetPasswordRepository);
  @override
  Future<Either<Failure, AppSuccess>> call(ForgetPasswordParams params) {
    return forgetPasswordRepository.forgetPassword(params);
  }
}

class ForgetPasswordParams extends Equatable{
  const ForgetPasswordParams({
    required this.emailOrUserName,
  });

  final String emailOrUserName;

  factory ForgetPasswordParams.fromJson(Map<String, dynamic> json) => ForgetPasswordParams(
    emailOrUserName: json["emailOrUserName"],
  );

  Map<String, dynamic> toJson() => {
    "emailOrUserName": emailOrUserName,
  };

  @override
  List<Object?> get props => [emailOrUserName];
}
