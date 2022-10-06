import 'package:bloc/bloc.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/authentication/domain/use_cases/post_login_usecase.dart';
import 'package:wmd/features/authentication/domain/use_cases/post_register_usecase.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final PostLoginUseCase postLoginUseCase;
  final PostRegisterUseCase postRegisterUseCase;
  AuthenticationCubit(this.postLoginUseCase, this.postRegisterUseCase)
      : super(AuthenticationInitial());

  postLogin({required Map<String, dynamic> map}) async {
    emit(LoadingState());
    final result = await postLoginUseCase(LoginParams.fromJson(map));
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) => emit(SuccessState(appSuccess: appSuccess)));
  }

  postRegister({required Map<String, dynamic> map}) async {
    emit(LoadingState());
    final result = await postRegisterUseCase(RegisterParams.fromJson(map));
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) => emit(SuccessState(appSuccess: appSuccess)));
  }
}
