import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:dartz/dartz.dart';

import '../models/get_linked_accounts_params.dart';
import '../../domain/entities/get_linked_accounts_entity.dart';
    
import '../../domain/repositories/linked_accounts_repository.dart';
import '../data_sources/linked_accounts_remote_datasource.dart';

class LinkedAccountsRepositoryImpl implements LinkedAccountsRepository {
  final LinkedAccountsRemoteDataSource remoteDataSource;

  LinkedAccountsRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, List<GetLinkedAccountsEntity>>> getLinkedAccounts(GetLinkedAccountsParams params) async {
    try {
      final result = await remoteDataSource.getLinkedAccounts(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
    
}

