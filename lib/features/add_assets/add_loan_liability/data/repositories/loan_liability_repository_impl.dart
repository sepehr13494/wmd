import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/features/add_assets/add_loan_liability/data/data_sources/loan_liability_remote_data_source.dart';
import 'package:wmd/features/add_assets/add_loan_liability/domain/repositories/loan_liability_repository.dart';
import 'package:wmd/features/add_assets/add_loan_liability/domain/use_cases/add_loan_liability_usecase.dart';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';

class LoanLiabilityRepositoryImpl implements LoanLiabilityRepository {
  final LoanLiabilityRemoteDataSource loanLiabilityRemoteDataSource;

  LoanLiabilityRepositoryImpl(this.loanLiabilityRemoteDataSource);
  @override
  Future<Either<Failure, AddAsset>> postLoanLiability(
      AddLoanLiabilityParams addLoanLiabilityParams) async {
    try {
      final result = await loanLiabilityRemoteDataSource
          .postLoanLiability(addLoanLiabilityParams);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    }
  }
}
