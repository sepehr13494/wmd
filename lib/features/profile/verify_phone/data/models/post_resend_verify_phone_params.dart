import 'package:equatable/equatable.dart';

class PostResendVerifyPhoneParams extends Equatable {
  const PostResendVerifyPhoneParams({
    required this.phoneNumber,
  });

  final String phoneNumber;

  factory PostResendVerifyPhoneParams.fromJson(Map<String, dynamic> json) =>
      PostResendVerifyPhoneParams(
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [phoneNumber];

  static const tParams = PostResendVerifyPhoneParams(phoneNumber: "01212331");
}
