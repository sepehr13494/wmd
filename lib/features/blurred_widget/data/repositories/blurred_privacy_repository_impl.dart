import 'dart:developer';

import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:dartz/dartz.dart';
import 'package:wmd/features/settings/core/data/data_sources/settings_remote_datasource.dart';
import 'package:wmd/features/settings/core/data/models/get_settings_params.dart';
import 'package:wmd/features/settings/core/data/models/put_settings_params.dart';

import '../models/get_is_blurred_params.dart';
import '../../domain/entities/is_blurred_entity.dart';
import '../models/set_blurred_params.dart';

import '../../domain/repositories/blurred_privacy_repository.dart';

class BlurredPrivacyRepositoryImpl implements BlurredPrivacyRepository {
  final SettingsRemoteDataSource remoteDataSource;

  BlurredPrivacyRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, IsBlurredEntity>> getIsBlurred(
      GetIsBlurredParams params) async {
    try {
      final result =
          await remoteDataSource.getSettings(const GetSettingsParams());
      return Right(IsBlurredEntity(isBlurred: result.isPrivacyMode));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }

  @override
  Future<Either<Failure, IsBlurredEntity>> setBlurred(
      SetBlurredParams params) async {
    try {
      final result = remoteDataSource
          .putSettings(PutSettingsParams(isPrivacyMode: params.isBlurred));
      return Right(IsBlurredEntity(isBlurred: params.isBlurred));
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }
}
