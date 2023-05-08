import 'package:wmd/core/error_and_success/exeptions.dart';
import 'package:wmd/core/error_and_success/failures.dart';

import 'package:dartz/dartz.dart';

import '../models/patch_preference_mobile_banner_params.dart';
import '../../domain/entities/patch_preference_mobile_banner_entity.dart';
    import '../models/patch_preference_language_params.dart';
import '../../domain/entities/patch_preference_language_entity.dart';
    import '../models/get_preference_params.dart';
import '../../domain/entities/get_preference_entity.dart';
    
import '../../domain/repositories/preference_repository.dart';
import '../data_sources/preference_remote_datasource.dart';

class PreferenceRepositoryImpl implements PreferenceRepository {
  final PreferenceRemoteDataSource remoteDataSource;

  PreferenceRepositoryImpl(this.remoteDataSource);

    @override
  Future<Either<Failure, PatchPreferenceMobileBannerEntity>> patchPreferenceMobileBanner(PatchPreferenceMobileBannerParams params) async {
    try {
      final result = await remoteDataSource.patchPreferenceMobileBanner(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
      @override
  Future<Either<Failure, PatchPreferenceLanguageEntity>> patchPreferenceLanguage(PatchPreferenceLanguageParams params) async {
    try {
      final result = await remoteDataSource.patchPreferenceLanguage(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
      @override
  Future<Either<Failure, GetPreferenceEntity>> getPreference(GetPreferenceParams params) async {
    try {
      final result = await remoteDataSource.getPreference(params);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure.fromServerException(error));
    } on AppException catch (error){
      return Left(AppFailure.fromAppException(error));
    }
  }
  
    
}

