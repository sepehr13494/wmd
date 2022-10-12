import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import '../use_cases/post_login_usecase.dart';
import '../use_cases/post_register_usecase.dart';
import '../use_cases/resend_email_usecase.dart';

abstract class LoginSignUpRepository {
  Future<Either<Failure, AppSuccess>> login(LoginParams loginParams);
  Future<Either<Failure, AppSuccess>> register(RegisterParams registerParams);
  Future<Either<Failure, AppSuccess>> resendEmail(ResendEmailParams resendEmailParams);
  /*Future<Either<Failure, AppSuccess>> googleLogin(GoogleLoginParams googleLoginParams);
  Future<Either<Failure, AppSuccess>> linkedInLogin(LinkedInLoginParams registerParams);
  Future<Either<Failure, AppSuccess>> twitterLogin(RegisterParams registerParams);
  Future<Either<Failure, AppSuccess>> appleLogin(RegisterParams registerParams);*/
}
