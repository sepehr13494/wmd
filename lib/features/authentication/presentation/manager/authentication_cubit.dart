import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/authentication/usecases/post_login_usecase.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final PostLoginUseCase postLoginUseCase;
  AuthenticationCubit(this.postLoginUseCase) : super(AuthenticationInitial());

  postLogin({required Map<String, dynamic> map}) async {
    emit(LoadingState());
    final result = await postLoginUseCase(LoginParams.fromJson(map));
    result.fold((failure) => emit(ErrorState(failure: failure)),
        (appSuccess) => emit(SuccessState(appSuccess: appSuccess)));
  }
}
