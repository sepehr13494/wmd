import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:dartz/dartz.dart';

import '../models/get_currency_params.dart';
import '../../domain/entities/get_currency_entity.dart';

import '../../domain/repositories/currency_repository.dart';
import '../data_sources/currency_remote_datasource.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyRemoteDataSource remoteDataSource;

  CurrencyRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, GetCurrencyConversionEntity>> getCurrency(
      GetCurrencyConversionParams params) async {
    try {
      final result = await remoteDataSource.getCurrency(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }
}
