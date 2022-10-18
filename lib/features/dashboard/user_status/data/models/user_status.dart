// To parse this JSON data, do
//
//     final userStatus = userStatusFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';

UserStatus userStatusFromJson(String str) =>
    UserStatus.fromJson(json.decode(str));

String userStatusToJson(UserStatus data) => json.encode(data.toJson());

class UserStatus extends Equatable {
  UserStatus({
    this.email,
    this.loginAt,
  });

  final String? email;
  final String? loginAt;

  factory UserStatus.fromJson(Map<String, dynamic> json) => UserStatus(
        email: json["email"],
        loginAt: json["loginAt"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "loginAt": loginAt,
      };

  @override
  List<Object?> get props => [email, loginAt];

  static final tUserStatusParam = UserStatus(
      email: "test@yopmail.com", loginAt: CustomizableDateTime.currentDate);
  static final tUserStatusResponse = {
    "email": "test@yopmail.com",
    "loginAt": CustomizableDateTime.currentDate
  };

  static final tUserStatus = UserStatus(
      email: "test@yopmail.com", loginAt: CustomizableDateTime.currentDate);
}
