import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:dartz/dartz.dart';

import '../models/get_asset_class_params.dart';
import '../../domain/entities/get_asset_class_entity.dart';
    import '../models/get_benchmark_params.dart';
import '../../domain/entities/get_benchmark_entity.dart';
    import '../models/get_custodian_performance_params.dart';
import '../../domain/entities/get_custodian_performance_entity.dart';
    
import '../../domain/repositories/performance_table_repository.dart';
import '../data_sources/performance_table_remote_datasource.dart';

class PerformanceTableRepositoryImpl implements PerformanceTableRepository {
  final PerformanceTableRemoteDataSource remoteDataSource;

  PerformanceTableRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, List<GetAssetClassEntity>>> getAssetClass(GetAssetClassParams params) async {
    try {
      final result = await remoteDataSource.getAssetClass(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
      @override
  Future<Either<Failure, List<GetBenchmarkEntity>>> getBenchmark(GetBenchmarkParams params) async {
    try {
      final result = await remoteDataSource.getBenchmark(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
      @override
  Future<Either<Failure, List<GetCustodianPerformanceEntity>>> getCustodianPerformance(GetCustodianPerformanceParams params) async {
    try {
      final result = await remoteDataSource.getCustodianPerformance(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
    
}

