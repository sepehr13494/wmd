import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/dashboard/user_status/data/models/user_status.dart';
import 'package:wmd/features/help/support/domain/use_cases/post_general_inquiry_usecase.dart';

part 'general_inquiry_state.dart';

class GeneralInquiryCubit extends Cubit<GeneralInquiryState> {
  final PostGeneralInquiryUseCase postGeneralInquiryUseCase;

  GeneralInquiryCubit(this.postGeneralInquiryUseCase) : super(LoadingState());

  postGeneralInquiry() async {
    emit(LoadingState());
    final result = await postGeneralInquiryUseCase(NoParams());
    result.fold((failure) {
      emit(ErrorState(failure: failure));
    }, (userStatusSuccess) {
      emit(GeneralInquirySaved(userStatus: userStatusSuccess));
    });
  }
}
