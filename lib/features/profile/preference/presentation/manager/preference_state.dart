part of 'preference_cubit.dart';

abstract class PreferenceState {}

class PatchPreferenceMobileBannerLoaded extends Equatable with PreferenceState {
  final PatchPreferenceMobileBannerEntity entity;

  PatchPreferenceMobileBannerLoaded({
    required this.entity,
  });

  @override
  List<Object?> get props => [
        entity,
      ];
}

class PatchPreferenceLanguageLoaded extends Equatable with PreferenceState {
  final PatchPreferenceLanguageEntity entity;

  PatchPreferenceLanguageLoaded({
    required this.entity,
  });

  @override
  List<Object?> get props => [
        entity,
      ];
}

class GetPreferenceLoaded extends Equatable with PreferenceState {
  final GetPreferenceEntity entity;

  GetPreferenceLoaded({
    required this.entity,
  });

  @override
  List<Object?> get props => [
        entity,
      ];
}
