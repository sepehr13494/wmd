import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/patch_preference_mobile_banner_params.dart';
import '../../domain/use_cases/patch_preference_mobile_banner_usecase.dart';
import '../../domain/entities/patch_preference_mobile_banner_entity.dart';
import '../../data/models/patch_preference_language_params.dart';
import '../../domain/use_cases/patch_preference_language_usecase.dart';
import '../../domain/entities/patch_preference_language_entity.dart';
import '../../data/models/get_preference_params.dart';
import '../../domain/use_cases/get_preference_usecase.dart';
import '../../domain/entities/get_preference_entity.dart';

part 'preference_state.dart';

class PreferenceCubit extends Cubit<PreferenceState> {
  final PatchPreferenceMobileBannerUseCase patchPreferenceMobileBannerUseCase;
  final PatchPreferenceLanguageUseCase patchPreferenceLanguageUseCase;
  final GetPreferenceUseCase getPreferenceUseCase;

  PreferenceCubit(
    this.patchPreferenceMobileBannerUseCase,
    this.patchPreferenceLanguageUseCase,
    this.getPreferenceUseCase,
  ) : super(LoadingState());

  patchPreferenceMobileBanner({required Map<String, dynamic> map}) async {
    emit(LoadingState());
    final result = await patchPreferenceMobileBannerUseCase(
        PatchPreferenceMobileBannerParams.fromJson(map));
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(PatchPreferenceMobileBannerLoaded(entity: entity));
    });
  }

  patchPreferenceLanguage({required PatchPreferenceLanguageParams param}) async {
    emit(LoadingState());
    final result =
        await patchPreferenceLanguageUseCase(param);
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(PatchPreferenceLanguageLoaded(entity: entity));
    });
  }

  getPreference() async {
    emit(LoadingState());
    final result = await getPreferenceUseCase(GetPreferenceParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(GetPreferenceLoaded(entity: entity));
    });
  }
}
