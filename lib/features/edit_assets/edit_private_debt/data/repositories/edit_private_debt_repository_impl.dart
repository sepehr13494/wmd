import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:dartz/dartz.dart';

import '../models/put_private_debt_params.dart';

    import '../models/delete_private_debt_params.dart';

    
import '../../domain/repositories/edit_private_debt_repository.dart';
import '../data_sources/edit_private_debt_remote_datasource.dart';

class EditPrivateDebtRepositoryImpl implements EditPrivateDebtRepository {
  final EditPrivateDebtRemoteDataSource remoteDataSource;

  EditPrivateDebtRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, AppSuccess>> putPrivateDebt(PutPrivateDebtParams params) async {
    try {
      final result = await remoteDataSource.putPrivateDebt(params);
      return const Right(AppSuccess(message: "Successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
      @override
  Future<Either<Failure, AppSuccess>> deletePrivateDebt(DeletePrivateDebtParams params) async {
    try {
      final result = await remoteDataSource.deletePrivateDebt(params);
      return const Right(AppSuccess(message: "Successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
    
}

