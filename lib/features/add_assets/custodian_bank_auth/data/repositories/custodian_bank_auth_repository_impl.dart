import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/delete_custodian_bank_status_params.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/models/put_custodian_bank_status_params.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/entities/status_entity.dart';

import '../models/get_custodian_bank_list_params.dart';
import '../../domain/entities/custodian_bank_entity.dart';
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
  Future<Either<Failure, List<CustodianBankEntity>>> getCustodianBankList(
      GetCustodianBankListParams params) async {
    try {
      final result = await remoteDataSource.getCustodianBankList(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    }
  }

  @override
  Future<Either<Failure, PostCustodianBankStatusEntity>>
      postCustodianBankStatus(PostCustodianBankStatusParams params) async {
    try {
      final result = await remoteDataSource.postCustodianBankStatus(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    }
  }

  @override
  Future<Either<Failure, PostCustodianBankStatusEntity>> putCustodianBankStatus(
      PutCustodianBankStatusParams params) async {
    try {
      final result = await remoteDataSource.putCustodianBankStatus(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    }
  }

  @override
  Future<Either<Failure, CustodianBankStatusEntity>> getCustodianBankStatus(
      GetCustodianBankStatusParams params) async {
    try {
      final result = await remoteDataSource.getCustodianBankStatus(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    }
  }

  @override
  Future<Either<Failure, AppSuccess>> deleteCustodianBankStatus(
      DeleteCustodianBankStatusParams params) async {
    try {
      final result = await remoteDataSource.deleteCustodianBankStatus(params);
      return const Right(AppSuccess(message: 'Deleted Succssfully'));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    }
  }

  @override
  Future<Either<Failure, List<StatusEntity>>> getCustodianStatusList(
      GetCustodianBankListParams params) async {
    try {
      final result = await remoteDataSource.getStatusList(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    }
  }
}
