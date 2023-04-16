import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/get_mandates_params.dart';
import '../../domain/use_cases/get_mandates_usecase.dart';

import '../../data/models/login_tfo_account_params.dart';
import '../../domain/use_cases/login_tfo_account_usecase.dart';

part 'tfo_login_state.dart';

class TfoLoginCubit extends Cubit<TfoLoginState> {
  final GetMandatesUseCase getMandatesUseCase;
  final LoginTfoAccountUseCase loginTfoAccountUseCase;

  TfoLoginCubit(
    this.getMandatesUseCase,
    this.loginTfoAccountUseCase,
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
    final result = await loginTfoAccountUseCase(LoginTfoAccountParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (appSuccess) {
      emit(SuccessState(appSuccess: appSuccess));
    });
  }
}
