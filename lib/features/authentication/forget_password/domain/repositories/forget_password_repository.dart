import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/authentication/forget_password/domain/use_cases/forget_password_usecase.dart';
import 'package:wmd/features/authentication/verify_email/data/models/verify_email_params.dart';

abstract class ForgetPasswordRepository{
  Future<Either<Failure, AppSuccess>> forgetPassword(ForgetPasswordParams forgetPasswordParams);
}