import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/features/help/support/data/models/support_status.dart';
import 'package:wmd/features/help/support/domain/use_cases/post_general_inquiry_usecase.dart';

part 'general_inquiry_state.dart';

class GeneralInquiryCubit extends Cubit<GeneralInquiryState> {
  final PostGeneralInquiryUseCase postGeneralInquiryUseCase;

  GeneralInquiryCubit(this.postGeneralInquiryUseCase) : super(LoadingState());

  postGeneralInquiry({required Map<String, dynamic> map}) async {
    emit(LoadingState());
    final result = await postGeneralInquiryUseCase(map);
    result.fold((failure) {
      emit(ErrorState(failure: failure));
    }, (statusSuccess) {
      emit(SuccessState(appSuccess: statusSuccess));
    });
  }

  postScheduleCall({required Map<String, dynamic> map}) async {
    emit(LoadingState());
    final result = await postGeneralInquiryUseCase(map);
    result.fold((failure) {
      emit(ErrorState(failure: failure));
    }, (statusSuccess) {
      emit(SuccessState(appSuccess: statusSuccess));
    });
  }
}
