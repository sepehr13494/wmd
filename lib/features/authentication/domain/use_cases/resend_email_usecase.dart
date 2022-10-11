import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/authentication/domain/repositories/auth_repository.dart';

class ResendEmailUseCase extends UseCase<AppSuccess,ResendEmailParams>{
  final AuthRepository authRepository;

  ResendEmailUseCase(this.authRepository);
  @override
  Future<Either<Failure, AppSuccess>> call(ResendEmailParams params) => authRepository.resendEmail(params);

}

class ResendEmailParams{

  const ResendEmailParams();

  factory ResendEmailParams.fromJson(Map<String, dynamic> json){
    return const ResendEmailParams();
  }

  toJson(){
    return {};
  }

  static const tResendEmailParams = ResendEmailParams();
}