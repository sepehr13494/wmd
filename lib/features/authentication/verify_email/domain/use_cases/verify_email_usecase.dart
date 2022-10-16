import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/authentication/verify_email/data/models/verify_email_params.dart';
import 'package:wmd/features/authentication/verify_email/domain/repositories/verify_email_repository.dart';

class VerifyEmailUseCase extends UseCase<AppSuccess,VerifyEmailParams>{

  final VerifyEmailRepository verifyEmailRepository;

  VerifyEmailUseCase(this.verifyEmailRepository);

  @override
  Future<Either<Failure, AppSuccess>> call(VerifyEmailParams params) {
    return verifyEmailRepository.verifyEmail(params);
  }

}