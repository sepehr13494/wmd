import 'package:equatable/equatable.dart';

class RegisterResponse extends Equatable{
  const RegisterResponse({
    required this.roles,
    required this.isSocial,
    required this.idToken,
    required this.expiresIn,
    required this.refreshToken,
    required this.accessToken,
    required this.tokenType,
  });

  final List<String> roles;
  final bool isSocial;
  final String idToken;
  final int expiresIn;
  final String refreshToken;
  final String accessToken;
  final String tokenType;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        roles: json["roles"] == null ? [] : List<String>.from(
            json["roles"].map((x) => x)),
        isSocial: json["isSocial"] ?? false,
        idToken: json["idToken"] ?? "",
        expiresIn: json["expiresIn"] ?? 0,
        refreshToken: json["refreshToken"] ?? "",
        accessToken: json["accessToken"] ?? "",
        tokenType: json["tokenType"] ?? "",
      );

  Map<String, dynamic> toJson() =>
      {
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "isSocial": isSocial,
        "idToken": idToken,
        "expiresIn": expiresIn,
        "refreshToken": refreshToken,
        "accessToken": accessToken,
        "tokenType": tokenType,
      };

  static const RegisterResponse tRegisterResponse = RegisterResponse(roles: [],
    isSocial: false,
    idToken: "idToken",
    expiresIn: 123456,
    refreshToken: "refreshToken",
    accessToken: "accessToken",
    tokenType: "tokenType",);

  @override
  List<Object?> get props => [
    roles,
    isSocial,
    idToken,
    expiresIn,
    refreshToken,
    accessToken,
    tokenType,
  ];
}
