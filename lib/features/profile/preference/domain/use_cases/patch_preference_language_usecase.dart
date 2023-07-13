import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';


import '../../data/models/patch_preference_language_params.dart';
import '../entities/patch_preference_language_entity.dart';
import '../repositories/preference_repository.dart';

class PatchPreferenceLanguageUseCase extends UseCase<PatchPreferenceLanguageEntity, PatchPreferenceLanguageParams> {
  final PreferenceRepository repository;

  PatchPreferenceLanguageUseCase(this.repository);
  
  @override
  Future<Either<Failure, PatchPreferenceLanguageEntity>> call(PatchPreferenceLanguageParams params) =>
      repository.patchPreferenceLanguage(params);
}
      

    