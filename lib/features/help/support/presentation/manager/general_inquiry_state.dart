part of 'general_inquiry_cubit.dart';

abstract class GeneralInquiryState {}

class GeneralInquirySaved extends Equatable with GeneralInquiryState {
  final UserStatus userStatus;

  GeneralInquirySaved({required this.userStatus});

  @override
  List<Object?> get props => [userStatus];
}
