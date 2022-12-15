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

  static const tFaqParam = Faq(
      id: 2,
      title: "In Which Jurisdictions Is The Family Office Regulated?",
      description:
          "The Family Office and Petiole Asset Management AG are subject to the oversight of six regulators in Bahrain, the Cayman Islands, Hong Kong, Saudi Arabia, Switzerland and the U.S.",
      sortOrder: 2);

  static final tFaqResponse = {
    "id": 2,
    "title": "In Which Jurisdictions Is The Family Office Regulated?",
    "description":
        "The Family Office and Petiole Asset Management AG are subject to the oversight of six regulators in Bahrain, the Cayman Islands, Hong Kong, Saudi Arabia, Switzerland and the U.S.",
    "sortOrder": 2
  };

  static final tFaqListResponse = [tFaqResponse, tFaqResponse];
  static final tFaqListParams = [tFaqParam, tFaqParam];
}
