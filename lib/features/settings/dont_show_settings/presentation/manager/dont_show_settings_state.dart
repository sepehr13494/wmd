part of 'dont_show_settings_cubit.dart';

abstract class DontShowSettingsState {}

class GetSettingsLoaded extends Equatable with DontShowSettingsState {
  final GetSettingsEntity getSettingsEntities;

  GetSettingsLoaded({
    required this.getSettingsEntities,
  });

  @override
  List<Object?> get props => [
        getSettingsEntities,
      ];
}
