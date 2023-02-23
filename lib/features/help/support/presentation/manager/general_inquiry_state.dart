part of 'general_inquiry_cubit.dart';

abstract class GeneralInquiryState {}

class GeneralInquirySaved extends Equatable with GeneralInquiryState {
  final SupportStatus status;

  GeneralInquirySaved({required this.status});

  @override
  List<Object?> get props => [status];
}

class GeneralInquiryLoadingState extends LoadingState {}
