import 'package:dartz/dartz.dart';
import '../../../../core/domain/usecases/usercase.dart';
import '../../../../core/error_and_success/failures.dart';
import '../../../../core/util/local_storage.dart';
import '../../domain/repositories/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  final LocalStorage localStorage;

  SplashRepositoryImpl(this.localStorage);

  @override
  Future<Either<Failure, bool>> checkLogin(NoParams noParams) async {
    try {
      return Right(await localStorage.getLogin());
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
