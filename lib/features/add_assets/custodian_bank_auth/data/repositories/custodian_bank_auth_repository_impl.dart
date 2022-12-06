import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:dartz/dartz.dart';

import '../models/get_custodian_bank_list_params.dart';
import '../../domain/entities/get_custodian_bank_list_entity.dart';
    import '../models/post_custodian_bank_status_params.dart';
import '../../domain/entities/post_custodian_bank_status_entity.dart';
    import '../models/get_custodian_bank_status_params.dart';
import '../../domain/entities/get_custodian_bank_status_entity.dart';
    
import '../../domain/repositories/custodian_bank_auth_repository.dart';
import '../data_sources/custodian_bank_auth_remote_datasource.dart';

class CustodianBankAuthRepositoryImpl implements CustodianBankAuthRepository {
  final CustodianBankAuthRemoteDataSource remoteDataSource;

  CustodianBankAuthRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, List<GetCustodianBankListEntity>>> getCustodianBankList(GetCustodianBankListParams params) async {
    try {
      final result = await remoteDataSource.getCustodianBankList(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    }
  }
  
      @override
  Future<Either<Failure, PostCustodianBankStatusEntity>> postCustodianBankStatus(PostCustodianBankStatusParams params) async {
    try {
      final result = await remoteDataSource.postCustodianBankStatus(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    }
  }
  
      @override
  Future<Either<Failure, GetCustodianBankStatusEntity>> getCustodianBankStatus(GetCustodianBankStatusParams params) async {
    try {
      final result = await remoteDataSource.getCustodianBankStatus(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    }
  }
  
    
}

