import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:dartz/dartz.dart';
import 'package:wmd/features/settings/core/data/data_sources/settings_remote_datasource.dart';
import 'package:wmd/features/settings/core/data/models/get_settings_params.dart';
import 'package:wmd/features/settings/core/data/models/get_settings_response.dart';
import 'package:wmd/features/settings/core/data/models/put_settings_params.dart';

import '../../domain/repositories/dont_show_settings_repository.dart';

class DontShowSettingsRepositoryImpl implements DontShowSettingsRepository {
  final SettingsRemoteDataSource remoteDataSource;

  DontShowSettingsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, AppSuccess>> putSettings(
      PutSettingsParams params) async {
    try {
      final result = await remoteDataSource.putSettings(params);
      return const Right(AppSuccess());
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }

  @override
  Future<Either<Failure, GetSettingsResponse>> getSettings(
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
}
