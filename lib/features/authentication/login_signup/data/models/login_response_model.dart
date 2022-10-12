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
    required this.accessToken,
    required this.refreshToken,
    required this.idToken,
    required this.tokenType,
  });

  String accessToken;
  String refreshToken;
  String idToken;
  String tokenType;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        idToken: json["id_token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "id_token": idToken,
        "token_type": tokenType,
      };

  @override
  List<Object?> get props => [accessToken, refreshToken, idToken, tokenType];
}
