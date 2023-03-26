part of 'verify_phone_cubit.dart';

abstract class VerifyPhoneState {}

class VerifyOtpLoaded extends Equatable with VerifyPhoneState {
  final OtpSentEntity entity;

  VerifyOtpLoaded({
    required this.entity,
  });

  @override
  List<Object?> get props => [
        entity,
      ];
}
