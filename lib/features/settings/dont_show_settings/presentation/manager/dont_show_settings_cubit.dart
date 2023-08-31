import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/settings/core/data/models/get_settings_params.dart';
import 'package:wmd/features/settings/core/data/models/put_settings_params.dart';
import 'package:wmd/features/settings/core/domain/entities/get_settings_entity.dart';
import 'package:wmd/features/settings/core/domain/use_cases/get_settings_usecase.dart';
import 'package:wmd/features/settings/core/domain/use_cases/put_settings_usecase.dart';

part 'dont_show_settings_state.dart';

class DontShowSettingsCubit extends Cubit<DontShowSettingsState> {
  final PutSettingsUseCase putSettingsUseCase;
  final GetSettingsUseCase getSettingsUseCase;

  DontShowSettingsCubit(
    this.putSettingsUseCase,
    this.getSettingsUseCase,
  ) : super(LoadingState());

  putSettings(PutSettingsParams param) async {
    emit(LoadingState());
    final result = await putSettingsUseCase(param);
    result.fold((failure) => emit(ErrorState(failure: failure)), (appSuccess) {
      emit(SuccessState(appSuccess: const AppSuccess()));
    });
  }

  getSettings() async {
    emit(LoadingState());
    final result = await getSettingsUseCase(const GetSettingsParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (entities) {
      emit(GetSettingsLoaded(getSettingsEntities: entities));
    });
  }
}
