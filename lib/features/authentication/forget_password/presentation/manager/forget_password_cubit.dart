import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/authentication/forget_password/domain/use_cases/forget_password_usecase.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<BaseState> {
  final ForgetPasswordUseCase forgetPasswordUseCase;
  ForgetPasswordCubit(this.forgetPasswordUseCase) : super(BaseInitialState());

  forgetPassword({required Map<String,dynamic> map}) async {
    emit(LoadingState());
    final verifyEmailParams = ForgetPasswordParams.fromJson(map);
    final result = await forgetPasswordUseCase(verifyEmailParams);
    result.fold((failure) => emit(ErrorState(failure: failure)),
            (appSuccess) => emit(SuccessState(appSuccess: appSuccess)));
  }
}
