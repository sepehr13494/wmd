import '../../domain/entities/patch_preference_language_entity.dart';

class PatchPreferenceLanguageResponse  extends PatchPreferenceLanguageEntity{
    PatchPreferenceLanguageResponse();

    factory PatchPreferenceLanguageResponse.fromJson(Map<String, dynamic> json) => PatchPreferenceLanguageResponse(
    );
    
    static final tResponse = PatchPreferenceLanguageResponse();
}
    