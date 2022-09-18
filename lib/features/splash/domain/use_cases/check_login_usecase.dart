import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/splash/domain/repositories/splash_repository.dart';

class CheckLoginUseCase extends UseCase<bool,NoParams>{

  final SplashRepository splashRepository;

  CheckLoginUseCase(this.splashRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async{
    return splashRepository.checkLogin(params);
  }
}