import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:dartz/dartz.dart';

import '../models/put_bank_manual_params.dart';

    import '../models/delete_bank_manual_params.dart';

    
import '../../domain/repositories/edit_bank_manual_repository.dart';
import '../data_sources/edit_bank_manual_remote_datasource.dart';

class EditBankManualRepositoryImpl implements EditBankManualRepository {
  final EditBankManualRemoteDataSource remoteDataSource;

  EditBankManualRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, AppSuccess>> putBankManual(PutBankManualParams params) async {
    try {
      final result = await remoteDataSource.putBankManual(params);
      return const Right(AppSuccess(message: "Successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
      @override
  Future<Either<Failure, AppSuccess>> deleteBankManual(DeleteBankManualParams params) async {
    try {
      final result = await remoteDataSource.deleteBankManual(params);
      return const Right(AppSuccess(message: "Successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
    
}

