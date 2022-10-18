import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/authentication/verify_email/data/models/verify_email_params.dart';
import 'package:wmd/features/authentication/verify_email/domain/use_cases/verify_email_usecase.dart';

part 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  final VerifyEmailUseCase verifyEmailUseCase;
  VerifyEmailCubit(this.verifyEmailUseCase) : super(LoadingState());

  verifyEmail({required Map<String, dynamic> map}) async {
    print("umad");
    emit(LoadingState());
    final verifyEmailParams = VerifyEmailParams.fromJson(map);
    final result = await verifyEmailUseCase(verifyEmailParams);
    result.fold((failure) => emit(ErrorState(failure: failure)),
            (appSuccess) => emit(SuccessState(appSuccess: appSuccess)));
  }
}
