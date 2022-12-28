import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/get_name_params.dart';
import '../../domain/use_cases/get_name_usecase.dart';
import '../../domain/entities/get_name_entity.dart';
import '../../data/models/set_name_params.dart';
import '../../domain/use_cases/set_name_usecase.dart';
import '../../domain/use_cases/set_number_usecase.dart';

part 'personal_information_state.dart';

class PersonalInformationCubit extends Cubit<PersonalInformationState> {
  final GetNameUseCase getNameUseCase;
  final SetNameUseCase setNameUseCase;
  final SetNumberUseCase setNumberUseCase;

  PersonalInformationCubit(
    this.getNameUseCase,
    this.setNameUseCase,
    this.setNumberUseCase,
  ) : super(LoadingState());

  getName() async {
    Future.delayed(const Duration(milliseconds: 200), () {
      emit(LoadingState());
    });
    final result = await getNameUseCase(GetNameParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (entity) {
      emit(PersonalInformationLoaded(getNameEntity: entity));
    });
  }

  setName({required Map<String, dynamic> map}) async {
    emit(LoadingState());
    final result = await setNameUseCase(SetNameParams.fromJson(map));
    result.fold((failure) => emit(ErrorState(failure: failure)), (appSuccess) {
      emit(SuccessState(appSuccess: appSuccess));
    });
  }

  setNumber({required Map<String, dynamic> map}) async {
    emit(LoadingState());
    final result = await setNumberUseCase(map);
    result.fold((failure) => emit(ErrorState(failure: failure)), (appSuccess) {
      emit(SuccessState(appSuccess: appSuccess));
    });
  }
}
