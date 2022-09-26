import 'package:dartz/dartz.dart';
import '../../../../core/domain/usecases/usercase.dart';
import '../../../../core/error_and_success/failures.dart';

abstract class SplashRepository {
  Future<Either<Failure, bool>> checkLogin(NoParams noParams);
}
