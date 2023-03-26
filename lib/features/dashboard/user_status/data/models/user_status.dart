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
    this.externalId,
    this.userId,
    this.emailVerified,
    this.mobileNumberVerified,
  });

  final String? email;
  final String? loginAt;
  final String? externalId;
  final String? userId;
  final bool? emailVerified;
  final bool? mobileNumberVerified;

  factory UserStatus.fromJson(Map<String, dynamic> json) => UserStatus(
        email: json["email"],
        loginAt: json["loginAt"],
        emailVerified: json["emailVerified"],
        userId: json["userId"],
        externalId: json["externalId"],
        mobileNumberVerified: json["mobileNumberVerified"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "loginAt": loginAt,
        "externalId": externalId,
        "userId": userId,
        "emailVerified": emailVerified,
        "mobileNumberVerified": mobileNumberVerified
      };

  @override
  List<Object?> get props =>
      [email, loginAt, externalId, userId, emailVerified];

  static final tUserStatusParam = UserStatus(
      email: "test@yopmail.com", loginAt: CustomizableDateTime.currentDate);
  static final tUserStatusResponse = {
    "email": "test@yopmail.com",
    "loginAt": CustomizableDateTime.currentDate,
    "externalId": "externalId",
    "userId": "userId",
    "emailVerified": false,
    "mobileNumberVerified": false,
  };

  static final tUserStatus = UserStatus(
      email: "test@yopmail.com", loginAt: CustomizableDateTime.currentDate);
}
