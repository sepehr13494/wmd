import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../repositories/login_sign_up_repository.dart';

class ResendEmailUseCase extends UseCase<AppSuccess,ResendEmailParams>{
  final LoginSignUpRepository loginSignUpRepository;

  ResendEmailUseCase(this.loginSignUpRepository);
  @override
  Future<Either<Failure, AppSuccess>> call(ResendEmailParams params) => loginSignUpRepository.resendEmail(params);

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