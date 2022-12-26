// To parse this JSON data, do
//
//     final userStatus = userStatusFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';

SupportStatus userStatusFromJson(String str) =>
    SupportStatus.fromJson(json.decode(str));

String userStatusToJson(SupportStatus data) => json.encode(data.toJson());

class SupportStatus extends Equatable {
  const SupportStatus({
    this.email,
    this.loginAt,
    this.externalId,
    this.userId,
    this.emailVerified,
  });

  final String? email;
  final String? loginAt;
  final String? externalId;
  final String? userId;
  final bool? emailVerified;

  factory SupportStatus.fromJson(Map<String, dynamic> json) => SupportStatus(
        email: json["email"],
        loginAt: json["loginAt"],
        emailVerified: json["emailVerified"],
        userId: json["userId"],
        externalId: json["externalId"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "loginAt": loginAt,
        "externalId": externalId,
        "userId": userId,
        "emailVerified": emailVerified
      };

  @override
  List<Object?> get props =>
      [email, loginAt, externalId, userId, emailVerified];

  static final tSupportStatusParam = SupportStatus(
      email: "test@yopmail.com", loginAt: CustomizableDateTime.currentDate);
  static final tUserStatusResponse = {
    "email": "test@yopmail.com",
    "loginAt": CustomizableDateTime.currentDate,
    "externalId": "externalId",
    "userId": "userId",
    "emailVerified": false
  };

  static final tSupportStatus = SupportStatus(
      email: "test@yopmail.com", loginAt: CustomizableDateTime.currentDate);
}
