import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/delete_mandate_params.dart';

import '../repositories/mandate_status_repository.dart';

class DeleteMandateUseCase extends UseCase<AppSuccess, DeleteMandateParams> {
  final MandateStatusRepository repository;

  DeleteMandateUseCase(this.repository);
  
  @override
  Future<Either<Failure, AppSuccess>> call(DeleteMandateParams params) =>
      repository.deleteMandate(params);
}
      

    