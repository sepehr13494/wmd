import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:dartz/dartz.dart';

import '../models/get_all_valuation_params.dart';
import '../../domain/entities/get_all_valuation_entity.dart';
import '../models/get_valuation_performance_response.dart';
import '../models/post_valuation_params.dart';

import '../models/get_valuation_performance_params.dart';
import '../../domain/entities/valuation_history_entity.dart';

import '../../domain/repositories/valuation_repository.dart';
import '../data_sources/valuation_remote_datasource.dart';

class ValuationRepositoryImpl implements ValuationRepository {
  final ValuationRemoteDataSource remoteDataSource;

  ValuationRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<GetAllValuationEntity>>> getAllValuation(
      GetAllValuationParams params) async {
    try {
      final result = await remoteDataSource.getAllValuation(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }

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
  Future<Either<Failure, GetValuationPerformanceResponse>>
      getValuationPerformance(GetValuationPerformanceParams params) async {
    try {
      final result = await remoteDataSource.getValuationPerformance(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }
}
