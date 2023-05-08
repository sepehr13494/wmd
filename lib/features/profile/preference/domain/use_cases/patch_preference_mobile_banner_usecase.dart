import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/patch_preference_mobile_banner_params.dart';
import '../entities/patch_preference_mobile_banner_entity.dart';
import '../repositories/preference_repository.dart';

class PatchPreferenceMobileBannerUseCase extends UseCase<PatchPreferenceMobileBannerEntity, PatchPreferenceMobileBannerParams> {
  final PreferenceRepository repository;

  PatchPreferenceMobileBannerUseCase(this.repository);
  
  @override
  Future<Either<Failure, PatchPreferenceMobileBannerEntity>> call(PatchPreferenceMobileBannerParams params) =>
      repository.patchPreferenceMobileBanner(params);
}
      

    