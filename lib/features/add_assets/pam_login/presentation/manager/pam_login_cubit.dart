import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/get_mandates_params.dart';
import '../../domain/use_cases/get_mandates_usecase.dart';

import '../../data/models/login_pam_account_params.dart';
import '../../domain/use_cases/login_pam_account_usecase.dart';

part 'pam_login_state.dart';

class PamLoginCubit extends Cubit<PamLoginState> {
  final GetPamMandatesUseCase getMandatesUseCase;
  final LoginPamAccountUseCase loginPamAccountUseCase;

  PamLoginCubit(
    this.getMandatesUseCase,
    this.loginPamAccountUseCase,
  ) : super(InitialState());

  getMandates() async {
    emit(LoadingState());
    final result = await getMandatesUseCase(const GetMandatesParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (appSuccess) {
      emit(SuccessState(appSuccess: appSuccess));
    });
  }

  loginTfoAccount() async {
    emit(LoadingState());
    final result = await loginPamAccountUseCase(LoginPamAccountParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (appSuccess) {
      emit(SuccessState(appSuccess: appSuccess));
    });
  }
}
