import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/succeses.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/profile/personal_information/domain/entities/user_mandata_entity.dart';
import 'package:wmd/features/profile/personal_information/domain/use_cases/get_user_mandata_usecase.dart';

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
  final GetUserMandataUseCase getUserMandataUseCase;

  PersonalInformationCubit(
    this.getNameUseCase,
    this.setNameUseCase,
    this.setNumberUseCase,
    this.getUserMandataUseCase,
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
      emit(SuccessStateName(appSuccess: appSuccess));
    });
  }

  setNumber({required Map<String, dynamic> map}) async {
    emit(LoadingState());
    final result = await setNumberUseCase(map);
    result.fold((failure) => emit(ErrorState(failure: failure)), (appSuccess) {
      emit(SuccessStatePhone(appSuccess: appSuccess));
      getName();
    });
  }

  getUserMandate() async {
    emit(LoadingState());
    final result = await getUserMandataUseCase(NoParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (appSuccess) {
      emit(UserMandateLoaded(entity: appSuccess));
    });
  }
}
