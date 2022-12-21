import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/reset_params.dart';

import '../repositories/profile_reset_password_repository.dart';

class ResetUseCase extends UseCase<AppSuccess, ResetParams> {
  final ProfileResetPasswordRepository repository;

  ResetUseCase(this.repository);
  
  @override
  Future<Either<Failure, AppSuccess>> call(ResetParams params) =>
      repository.reset(params);
}
      

    