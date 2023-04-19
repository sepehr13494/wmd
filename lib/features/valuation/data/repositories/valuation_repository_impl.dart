import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/features/valuation/data/models/get_valuation_params.dart';
import 'package:wmd/features/valuation/domain/entities/get_valuation_entity.dart';

import '../models/post_valuation_params.dart';
import '../models/update_valuation_params.dart';
import '../../domain/entities/update_valuation_entity.dart';

import '../../domain/repositories/valuation_repository.dart';
import '../data_sources/valuation_remote_datasource.dart';

class AssetValuationRepositoryImpl implements AssetValuationRepository {
  final AssetValuationRemoteDataSource remoteDataSource;

  AssetValuationRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, AppSuccess>> postValuation(
      PostValuationParams params) async {
    try {
      final result = await remoteDataSource.postValuation(params);
      return const Right(AppSuccess(message: "successfully done"));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }

  @override
  Future<Either<Failure, UpdateValuationEntity>> updateValuation(
      UpdateValuationParams params) async {
    try {
      final result = await remoteDataSource.updateValuation(params);
      return Right(result);
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
      final result = await remoteDataSource.deleteValuation(params);
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
      final result = await remoteDataSource.getValuationById(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }
}
