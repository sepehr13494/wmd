import 'package:dartz/dartz.dart';
import '../../../../core/error_and_success/failures.dart';
import '../../../../core/error_and_success/succeses.dart';
import '../use_cases/post_login_usecase.dart';

abstract class AuthRepository {
  Future<Either<Failure, AppSuccess>> login(LoginParams loginParams);
  Future<Either<Failure, AppSuccess>> register(LoginParams loginParams);
}
