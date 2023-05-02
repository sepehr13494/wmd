import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/perform_logout_params.dart';

import '../repositories/logout_repository.dart';

class PerformLogoutUseCase extends UseCase<AppSuccess, PerformLogoutParams> {
  final LogoutRepository repository;

  PerformLogoutUseCase(this.repository);
  
  @override
  Future<Either<Failure, AppSuccess>> call(PerformLogoutParams params) =>
      repository.performLogout(params);
}
      

    