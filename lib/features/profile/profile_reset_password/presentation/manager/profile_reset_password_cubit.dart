import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/reset_params.dart';
import '../../domain/use_cases/reset_usecase.dart';



part 'profile_reset_password_state.dart';

class ProfileResetPasswordCubit extends Cubit<ProfileResetPasswordState> {

  final ResetUseCase resetUseCase;


  ProfileResetPasswordCubit(
    this.resetUseCase,
  ) : super(LoadingState());

  reset({required Map<String, dynamic> map}) async {
    emit(LoadingState());
    final result = await resetUseCase(ResetParams.fromJson(map));
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) {
      emit(SuccessState(appSuccess: appSuccess));
      
    });
  }
  

}

    