import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/perform_logout_params.dart';
import '../../domain/use_cases/perform_logout_usecase.dart';


class LogoutCubit extends Cubit<BaseState> {

  final PerformLogoutUseCase performLogoutUseCase;


  LogoutCubit(
    this.performLogoutUseCase,
  ) : super(LoadingState());

  performLogout() async {
    emit(LoadingState());
    final result = await performLogoutUseCase(PerformLogoutParams());
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) {
      emit(SuccessState(appSuccess: appSuccess));
      
    });
  }
  

}

    