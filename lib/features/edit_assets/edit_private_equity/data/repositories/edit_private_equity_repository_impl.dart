import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:dartz/dartz.dart';

import '../models/put_private_equity_params.dart';

    import '../models/delete_private_equity_params.dart';

    
import '../../domain/repositories/edit_private_equity_repository.dart';
import '../data_sources/edit_private_equity_remote_datasource.dart';

class EditPrivateEquityRepositoryImpl implements EditPrivateEquityRepository {
  final EditPrivateEquityRemoteDataSource remoteDataSource;

  EditPrivateEquityRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, AppSuccess>> putPrivateEquity(PutPrivateEquityParams params) async {
    try {
      final result = await remoteDataSource.putPrivateEquity(params);
      return const Right(AppSuccess(message: "Successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
      @override
  Future<Either<Failure, AppSuccess>> deletePrivateEquity(DeletePrivateEquityParams params) async {
    try {
      final result = await remoteDataSource.deletePrivateEquity(params);
      return const Right(AppSuccess(message: "Successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
    
}

