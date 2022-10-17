import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable{
  LoginResponse({
    required this.roles,
    required this.isSocial,
    required this.idToken,
    required this.expiresIn,
    required this.refreshToken,
    required this.accessToken,
    required this.tokenType,
  });

  List<String> roles;
  bool isSocial;
  String idToken;
  int expiresIn;
  String refreshToken;
  String accessToken;
  String tokenType;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    roles: json["roles"]==null ? [] : List<String>.from(json["roles"].map((x) => x)),
    isSocial: json["isSocial"]??false,
    idToken: json["idToken"]??"",
    expiresIn: json["expiresIn"]??0,
    refreshToken: json["refreshToken"]??"",
    accessToken: json["accessToken"]??"",
    tokenType: json["tokenType"]??"",
  );

  Map<String, dynamic> toJson() => {
    "roles": List<dynamic>.from(roles.map((x) => x)),
    "isSocial": isSocial,
    "idToken": idToken,
    "expiresIn": expiresIn,
    "refreshToken": refreshToken,
    "accessToken": accessToken,
    "tokenType": tokenType,
  };

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
