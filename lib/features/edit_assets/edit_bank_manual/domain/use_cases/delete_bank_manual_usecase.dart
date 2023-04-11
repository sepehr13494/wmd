import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/delete_bank_manual_params.dart';

import '../repositories/edit_bank_manual_repository.dart';

class DeleteBankManualUseCase extends UseCase<AppSuccess, DeleteBankManualParams> {
  final EditBankManualRepository repository;

  DeleteBankManualUseCase(this.repository);
  
  @override
  Future<Either<Failure, AppSuccess>> call(DeleteBankManualParams params) =>
      repository.deleteBankManual(params);
}
      

    