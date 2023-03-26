import 'package:equatable/equatable.dart';
import 'package:wmd/features/profile/verify_phone/domain/entities/otp_sent_entity.dart';

class PostResendVerifyPhoneResponse extends OtpSentEntity {
  const PostResendVerifyPhoneResponse({required super.identifier});

  factory PostResendVerifyPhoneResponse.fromJson(Map<String, dynamic> json) =>
      PostResendVerifyPhoneResponse(
        identifier: json["identifier"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "identifier": identifier,
      };

  @override
  List<Object?> get props => [
        identifier,
      ];

  static const tResponse = PostResendVerifyPhoneResponse(identifier: "23233");
}
