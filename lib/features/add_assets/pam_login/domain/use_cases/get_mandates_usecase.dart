import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/get_mandates_params.dart';

import '../repositories/pam_login_repository.dart';

class GetPamMandatesUseCase extends UseCase<AppSuccess, GetMandatesParams> {
  final PamLoginRepository repository;

  GetPamMandatesUseCase(this.repository);

  @override
  Future<Either<Failure, AppSuccess>> call(GetMandatesParams params) =>
      repository.getMandates(params);
}
