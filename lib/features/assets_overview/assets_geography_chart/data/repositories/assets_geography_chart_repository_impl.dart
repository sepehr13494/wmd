import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:dartz/dartz.dart';

import '../models/get_assets_geography_params.dart';
import '../../domain/entities/get_assets_geography_entity.dart';
    
import '../../domain/repositories/assets_geography_chart_repository.dart';
import '../data_sources/assets_geography_chart_remote_datasource.dart';

class AssetsGeographyChartRepositoryImpl implements AssetsGeographyChartRepository {
  final AssetsGeographyChartRemoteDataSource remoteDataSource;

  AssetsGeographyChartRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, List<GetAssetsGeographyEntity>>> getAssetsGeography(GetAssetsGeographyParams params) async {
    try {
      final result = await remoteDataSource.getAssetsGeography(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
    
}

