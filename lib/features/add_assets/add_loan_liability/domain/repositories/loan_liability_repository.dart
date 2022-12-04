import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_loan_liability/domain/use_cases/add_loan_liability_usecase.dart';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';

abstract class LoanLiabilityRepository {
  Future<Either<Failure, AddAsset>> postLoanLiability(
      AddLoanLiabilityParams addLoanLiabilityParams);
}
