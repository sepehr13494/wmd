import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/request_new_custodian_params.dart';

import '../repositories/request_new_custodian_repository.dart';

class RequestNewCustodianUseCase extends UseCase<AppSuccess, RequestNewCustodianParams> {
  final RequestNewCustodianRepository repository;

  RequestNewCustodianUseCase(this.repository);
  
  @override
  Future<Either<Failure, AppSuccess>> call(RequestNewCustodianParams params) =>
      repository.requestNewCustodian(params);
}
      

    