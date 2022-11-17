// To parse this JSON data, do
//
//     final bankSaveFailResponseModel = bankSaveFailResponseModelFromJson(jsonString);

import 'dart:convert';

PrivateDebtFailResponseModel privateDebtFailResponseModelromJson(String str) =>
    PrivateDebtFailResponseModel.fromJson(json.decode(str));

String privateDebtFailResponseModelToJson(PrivateDebtFailResponseModel data) =>
    json.encode(data.toJson());

class PrivateDebtFailResponseModel {
  PrivateDebtFailResponseModel({
    required this.type,
    required this.title,
    required this.status,
    required this.detail,
    required this.instance,
  });

  String type;
  String title;
  int status;
  String detail;
  String instance;

  factory PrivateDebtFailResponseModel.fromJson(Map<String, dynamic> json) =>
      PrivateDebtFailResponseModel(
        type: json["type"],
        title: json["title"],
        status: json["status"],
        detail: json["detail"],
        instance: json["instance"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "status": status,
        "detail": detail,
        "instance": instance,
      };

  static const tPrivateDebtFailResponseModel = {
    "type": "test error type",
    "title": "test error title",
    "status": 400,
    "detail": "test error detail",
    "instance": "test error instance"
  };
}
