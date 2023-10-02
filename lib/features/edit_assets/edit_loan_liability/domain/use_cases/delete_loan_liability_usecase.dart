import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/delete_loan_liability_params.dart';

import '../repositories/edit_loan_liability_repository.dart';

class DeleteLoanLiabilityUseCase extends UseCase<AppSuccess, DeleteLoanLiabilityParams> {
  final EditLoanLiabilityRepository repository;

  DeleteLoanLiabilityUseCase(this.repository);
  
  @override
  Future<Either<Failure, AppSuccess>> call(DeleteLoanLiabilityParams params) =>
      repository.deleteLoanLiability(params);
}
      

    