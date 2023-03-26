import 'package:equatable/equatable.dart';

class PostVerifyPhoneParams extends Equatable {
  const PostVerifyPhoneParams({
    required this.identifier,
    required this.code,
  });

  final String identifier;
  final String code;

  factory PostVerifyPhoneParams.fromJson(Map<String, dynamic> json) =>
      PostVerifyPhoneParams(
        identifier: json["identifier"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "code": code,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [identifier, code];

  static const tParams =
      PostVerifyPhoneParams(identifier: "Pass123!", code: "Pass123!");
}
