import 'dart:developer';

import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:dartz/dartz.dart';

import '../models/get_is_blurred_params.dart';
import '../../domain/entities/is_blurred_entity.dart';
import '../models/set_blurred_params.dart';

import '../../domain/repositories/blurred_privacy_repository.dart';
import '../data_sources/blurred_privacy_remote_datasource.dart';

class BlurredPrivacyRepositoryImpl implements BlurredPrivacyRepository {
  final BlurredPrivacyRemoteDataSource remoteDataSource;

  BlurredPrivacyRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, IsBlurredEntity>> getIsBlurred(
      GetIsBlurredParams params) async {
    try {
      final result = await remoteDataSource.getIsBlurred(params);
      return Right(result);
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
      final result = await remoteDataSource.setBlurred(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error) {
      return Left(AppFailure.fromAppException(error));
    }
  }
}
