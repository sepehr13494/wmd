import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:dartz/dartz.dart';

import '../models/get_allocation_params.dart';
import '../../domain/entities/get_allocation_entity.dart';
    import '../models/get_geographic_params.dart';
import '../../domain/entities/get_geographic_entity.dart';
    import '../models/get_pie_params.dart';
import '../../domain/entities/get_pie_entity.dart';
    
import '../../domain/repositories/dashboard_charts_repository.dart';
import '../data_sources/dashboard_charts_remote_datasource.dart';

class DashboardChartsRepositoryImpl implements DashboardChartsRepository {
  final DashboardChartsRemoteDataSource remoteDataSource;

  DashboardChartsRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, List<GetAllocationEntity>>> getAllocation(GetAllocationParams params) async {
    try {
      final result = await remoteDataSource.getAllocation(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
      @override
  Future<Either<Failure, List<GetGeographicEntity>>> getGeographic(GetGeographicParams params) async {
    try {
      final result = await remoteDataSource.getGeographic(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
      @override
  Future<Either<Failure, List<GetPieEntity>>> getPie(GetPieParams params) async {
    try {
      final result = await remoteDataSource.getPie(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
    
}

