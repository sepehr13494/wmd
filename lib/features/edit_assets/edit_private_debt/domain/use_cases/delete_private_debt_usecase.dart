import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/delete_private_debt_params.dart';

import '../repositories/edit_private_debt_repository.dart';

class DeletePrivateDebtUseCase extends UseCase<AppSuccess, DeletePrivateDebtParams> {
  final EditPrivateDebtRepository repository;

  DeletePrivateDebtUseCase(this.repository);
  
  @override
  Future<Either<Failure, AppSuccess>> call(DeletePrivateDebtParams params) =>
      repository.deletePrivateDebt(params);
}
      

    