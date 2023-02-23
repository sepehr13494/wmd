import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/presentation/bloc/base_cubit.dart';
import 'package:wmd/core/util/firebase_analytics.dart';
import 'package:wmd/features/help/support/data/models/support_status.dart';
import 'package:wmd/features/help/support/domain/use_cases/post_general_inquiry_usecase.dart';
import 'package:wmd/features/help/support/domain/use_cases/post_schedule_call_usecase.dart';

part 'general_inquiry_state.dart';

class GeneralInquiryCubit extends Cubit<GeneralInquiryState> {
  final PostGeneralInquiryUseCase postGeneralInquiryUseCase;
  final PostScheduleCallUseCase postScheduleCallUseCase;

  GeneralInquiryCubit(
      this.postGeneralInquiryUseCase, this.postScheduleCallUseCase)
      : super(LoadingState());

  postGeneralInquiry({required Map<String, dynamic> map}) async {
    emit(GeneralInquiryLoadingState());

    await AnalyticsUtils.triggerEvent(
        action: AnalyticsUtils.helpSupportAction,
        params: AnalyticsUtils.contactBusinessTeamEvent);

    final result = await postGeneralInquiryUseCase(map);
    result.fold((failure) {
      emit(ErrorState(failure: failure));
    }, (statusSuccess) {
      emit(SuccessState(appSuccess: statusSuccess));
    });
  }

  postScheduleCall({required Map<String, dynamic> map}) async {
    emit(LoadingState());

    await AnalyticsUtils.triggerEvent(
        action: AnalyticsUtils.helpSupportAction,
        params: AnalyticsUtils.scheduleCallEvent);

    final result = await postScheduleCallUseCase(map);
    result.fold((failure) {
      emit(ErrorState(failure: failure));
    }, (statusSuccess) {
      emit(SuccessState(appSuccess: statusSuccess));
    });
  }
}
