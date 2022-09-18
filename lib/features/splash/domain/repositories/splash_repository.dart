import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';

abstract class SplashRepository{
  Future<Either<Failure,bool>> checkLogin(NoParams noParams);
}