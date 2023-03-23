import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:dartz/dartz.dart';

import '../models/get_settings_params.dart';
import '../../domain/entities/get_settings_entity.dart';
import '../models/put_settings_params.dart';
import '../../domain/entities/put_settings_entity.dart';

import '../../domain/repositories/settings_repository.dart';
import '../data_sources/settings_remote_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsRemoteDataSource remoteDataSource;

  SettingsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, GetSettingsEntity>> getSettings(
      GetSettingsParams params) async {
    try {
      final result = await remoteDataSource.getSettings(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }

  @override
  Future<Either<Failure, PutSettingsEntity>> putSettings(
      PutSettingsParams params) async {
    try {
      final result = await remoteDataSource.putSettings(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }
}
