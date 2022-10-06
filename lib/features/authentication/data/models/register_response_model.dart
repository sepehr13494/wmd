// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

class RegisterResponse extends Equatable {
  RegisterResponse();

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse();

  Map<String, dynamic> toJson() => {};

  @override
  List<Object?> get props => [];
}
