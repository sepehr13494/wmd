import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:dartz/dartz.dart';

import '../models/get_currency_params.dart';
import '../../domain/entities/get_currency_entity.dart';
    
import '../../domain/repositories/currency_chart_repository.dart';
import '../data_sources/currency_chart_remote_datasource.dart';

class CurrencyChartRepositoryImpl implements CurrencyChartRepository {
  final CurrencyChartRemoteDataSource remoteDataSource;

  CurrencyChartRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, List<GetCurrencyEntity>>> getCurrency(GetCurrencyParams params) async {
    try {
      final result = await remoteDataSource.getCurrency(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
    
}

