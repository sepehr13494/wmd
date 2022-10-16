import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/authentication/verify_email/data/models/verify_email_params.dart';

abstract class VerifyEmailRepository{
  Future<Either<Failure, AppSuccess>> verifyEmail(VerifyEmailParams verifyEmailParams);
}