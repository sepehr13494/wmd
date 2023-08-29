import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/valuation/data/data_sources/transaction_remote_datasource.dart';
import 'package:wmd/features/valuation/data/models/get_valuation_params.dart';
import 'package:wmd/features/valuation/domain/entities/get_valuation_entity.dart';
import 'package:wmd/features/valuation/domain/repositories/transaction_repository.dart';

import '../models/post_valuation_params.dart';
import '../models/update_valuation_params.dart';

class AssetTransactionRepositoryImpl implements AssetTransactionRepository {
  final AssetTransactionRemoteDataSource remoteDataSource;

  AssetTransactionRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, AppSuccess>> postValuation(
      PostValuationParams params) async {
    try {
      final result = await remoteDataSource.postTransaction(params);
      return const Right(AppSuccess(message: "successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }

  @override
  Future<Either<Failure, AppSuccess>> updateValuation(
      UpdateValuationParams params) async {
    try {
      final result = await remoteDataSource.updateTransaction(params);
      return const Right(AppSuccess(message: "successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }

  @override
  Future<Either<Failure, AppSuccess>> deleteValuation(
      GetValuationParams params) async {
    try {
      final result = await remoteDataSource.deleteTransaction(params);
      return const Right(AppSuccess(message: "successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }

  @override
  Future<Either<Failure, GetValuationEntity>> getValuationById(
      GetValuationParams params) async {
    try {
      final result = await remoteDataSource.getTransactionById(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }
}
