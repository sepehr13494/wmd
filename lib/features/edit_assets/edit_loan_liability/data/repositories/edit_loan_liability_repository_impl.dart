import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:dartz/dartz.dart';

import '../models/put_loan_liability_params.dart';

    import '../models/delete_loan_liability_params.dart';

    
import '../../domain/repositories/edit_loan_liability_repository.dart';
import '../data_sources/edit_loan_liability_remote_datasource.dart';

class EditLoanLiabilityRepositoryImpl implements EditLoanLiabilityRepository {
  final EditLoanLiabilityRemoteDataSource remoteDataSource;

  EditLoanLiabilityRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, AppSuccess>> putLoanLiability(PutLoanLiabilityParams params) async {
    try {
      final result = await remoteDataSource.putLoanLiability(params);
      return const Right(AppSuccess(message: "Successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
      @override
  Future<Either<Failure, AppSuccess>> deleteLoanLiability(DeleteLoanLiabilityParams params) async {
    try {
      final result = await remoteDataSource.deleteLoanLiability(params);
      return const Right(AppSuccess(message: "Successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
    
}

