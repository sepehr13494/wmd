import 'package:dartz/dartz.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/patch_preference_mobile_banner_params.dart';
import '../entities/patch_preference_mobile_banner_entity.dart';
import '../../data/models/patch_preference_language_params.dart';
import '../entities/patch_preference_language_entity.dart';
import '../../data/models/get_preference_params.dart';
import '../entities/get_preference_entity.dart';


abstract class PreferenceRepository {
  Future<Either<Failure, PatchPreferenceMobileBannerEntity>> patchPreferenceMobileBanner(PatchPreferenceMobileBannerParams params);
  Future<Either<Failure, PatchPreferenceLanguageEntity>> patchPreferenceLanguage(PatchPreferenceLanguageParams params);
  Future<Either<Failure, GetPreferenceEntity>> getPreference(GetPreferenceParams params);

}
    