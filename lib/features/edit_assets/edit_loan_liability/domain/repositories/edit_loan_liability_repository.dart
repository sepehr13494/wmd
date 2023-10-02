import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';

import '../../data/models/put_loan_liability_params.dart';

import '../../data/models/delete_loan_liability_params.dart';



abstract class EditLoanLiabilityRepository {
  Future<Either<Failure, AppSuccess>> putLoanLiability(PutLoanLiabilityParams params);
  Future<Either<Failure, AppSuccess>> deleteLoanLiability(DeleteLoanLiabilityParams params);

}
    