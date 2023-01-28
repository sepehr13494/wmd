import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';

import '../../data/models/post_verify_phone_params.dart';
import '../../domain/use_cases/post_verify_phone_usecase.dart';

import '../../data/models/post_resend_verify_phone_params.dart';
import '../../domain/use_cases/post_resend_verify_phone_usecase.dart';

part 'verify_phone_state.dart';

class VerifyPhoneCubit extends Cubit<VerifyPhoneState> {
  final PostVerifyPhoneUseCase postVerifyPhoneUseCase;
  final PostResendVerifyPhoneUseCase postResendVerifyPhoneUseCase;

  VerifyPhoneCubit(
    this.postVerifyPhoneUseCase,
    this.postResendVerifyPhoneUseCase,
  ) : super(LoadingState());

  postVerifyPhone() async {
    emit(LoadingState());
    final result = await postVerifyPhoneUseCase(const PostVerifyPhoneParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (appSuccess) {
      emit(SuccessState(appSuccess: appSuccess));
    });
  }

  postResendVerifyPhone() async {
    emit(LoadingState());
    final result =
        await postResendVerifyPhoneUseCase(PostResendVerifyPhoneParams());
    result.fold((failure) => emit(ErrorState(failure: failure)), (appSuccess) {
      emit(SuccessState(appSuccess: appSuccess));
    });
  }
}
