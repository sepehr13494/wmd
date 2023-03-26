import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/profile/verify_phone/domain/entities/otp_sent_entity.dart';

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

  postVerifyPhone({required Map<String, dynamic> map}) async {
    emit(LoadingState());
    final result =
        await postVerifyPhoneUseCase(PostVerifyPhoneParams.fromJson(map));
    result.fold((failure) => emit(ErrorState(failure: failure)), (appSuccess) {
      emit(SuccessState(appSuccess: appSuccess));
    });
  }

  postResendVerifyPhone({required Map<String, dynamic> map}) async {
    emit(LoadingState());
    final result = await postResendVerifyPhoneUseCase(
        PostResendVerifyPhoneParams.fromJson(map));
    result.fold((failure) => emit(ErrorState(failure: failure)), (appSuccess) {
      emit(VerifyOtpLoaded(entity: appSuccess));
    });
  }
}
