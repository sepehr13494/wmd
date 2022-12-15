// To parse this JSON data, do
//
//     final userStatus = userStatusFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:wmd/core/extentions/date_time_ext.dart';

List<Faq> faqFromJson(List<dynamic> data) {
  final list = data.map((e) => Faq.fromJson(e)).toList();
  list.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
  return list;
}

String faqToJson(Faq data) => json.encode(data.toJson());

class Faq extends Equatable {
  const Faq({
    this.id,
    this.title,
    this.description,
    required this.sortOrder,
  });

  final int? id;
  final String? title;
  final String? description;
  final int sortOrder;

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        sortOrder: json["sortOrder"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "sortOrder": sortOrder,
      };

  @override
  List<Object?> get props => [id, title, description, sortOrder];

  // static final tUserStatusParam =
  //     Faq(email: "test@yopmail.com", loginAt: CustomizableDateTime.currentDate);
  // static final tUserStatusResponse = {
  //   "email": "test@yopmail.com",
  //   "loginAt": CustomizableDateTime.currentDate,
  //   "externalId": "externalId",
  //   "userId": "userId",
  //   "emailVerified": false
  // };

  // static final tUserStatus =
  //     Faq(email: "test@yopmail.com", loginAt: CustomizableDateTime.currentDate);
}
