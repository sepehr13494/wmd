import 'package:bloc/bloc.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/authentication/domain/use_cases/post_login_usecase.dart';

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
