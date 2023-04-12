import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/get_mandates_params.dart';

import '../repositories/tfo_login_repository.dart';

class GetMandatesUseCase extends UseCase<AppSuccess, GetMandatesParams> {
  final TfoLoginRepository repository;

  GetMandatesUseCase(this.repository);
  
  @override
  Future<Either<Failure, AppSuccess>> call(GetMandatesParams params) =>
      repository.getMandates(params);
}
      

    