import 'package:equatable/equatable.dart';

class VerifyEmailParams extends Equatable{
  VerifyEmailParams({
    required this.data,
    required this.ttl,
    required this.email,
  });

  String data;
  String ttl;
  String email;

  factory VerifyEmailParams.fromJson(Map<String, dynamic> json) => VerifyEmailParams(
    data: json["data"],
    ttl: json["ttl"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "ttl": ttl,
    "email": email,
  };

  @override
  List<Object?> get props => [data,ttl,email];
}
