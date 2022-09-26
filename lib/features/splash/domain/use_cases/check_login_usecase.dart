import 'package:dartz/dartz.dart';
import '../../../../core/domain/usecases/usercase.dart';
import '../../../../core/error_and_success/failures.dart';
import '../repositories/splash_repository.dart';

class CheckLoginUseCase extends UseCase<bool, NoParams> {
  final SplashRepository splashRepository;

  CheckLoginUseCase(this.splashRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return splashRepository.checkLogin(params);
  }
}
