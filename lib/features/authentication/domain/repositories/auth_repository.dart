import 'package:dartz/dartz.dart';
import 'package:wmd/features/authentication/domain/use_cases/google_login_usecase.dart';
import 'package:wmd/features/authentication/domain/use_cases/linkedin_login_usecase.dart';
import 'package:wmd/features/authentication/domain/use_cases/post_register_usecase.dart';
import '../../../../core/error_and_success/failures.dart';
import '../../../../core/error_and_success/succeses.dart';
import '../use_cases/post_login_usecase.dart';

abstract class AuthRepository {
  Future<Either<Failure, AppSuccess>> login(LoginParams loginParams);
  Future<Either<Failure, AppSuccess>> register(RegisterParams registerParams);
  /*Future<Either<Failure, AppSuccess>> googleLogin(GoogleLoginParams googleLoginParams);
  Future<Either<Failure, AppSuccess>> linkedInLogin(LinkedInLoginParams registerParams);
  Future<Either<Failure, AppSuccess>> twitterLogin(RegisterParams registerParams);
  Future<Either<Failure, AppSuccess>> appleLogin(RegisterParams registerParams);*/
}
