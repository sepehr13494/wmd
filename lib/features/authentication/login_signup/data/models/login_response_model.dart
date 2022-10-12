// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse extends Equatable {
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
  dynamic refreshToken;
  String accessToken;
  String tokenType;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        roles: List<String>.from(
            json["roles"] != null ? json["roles"].map((x) => x) : []),
        isSocial: json["isSocial"] ?? false,
        idToken: json["idToken"] ?? '',
        expiresIn: json["expiresIn"] ?? '',
        refreshToken: json["refreshToken"] ?? '',
        accessToken: json["accessToken"] ?? '',
        tokenType: json["tokenType"] ?? 'Bearer',
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
  // TODO: implement props
  List<Object?> get props => [
        roles,
        isSocial,
        idToken,
        expiresIn,
        refreshToken,
        accessToken,
        tokenType
      ];
}
