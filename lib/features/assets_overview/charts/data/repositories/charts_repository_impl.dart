import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:dartz/dartz.dart';

import '../models/get_chart_params.dart';
import '../../domain/entities/get_chart_entity.dart';
    
import '../../domain/repositories/charts_repository.dart';
import '../data_sources/charts_remote_datasource.dart';

class ChartsRepositoryImpl implements ChartsRepository {
  final ChartsRemoteDataSource remoteDataSource;

  ChartsRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, List<GetChartEntity>>> getChart(GetChartParams params) async {
    try {
      final result = await remoteDataSource.getChart(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
    
}

