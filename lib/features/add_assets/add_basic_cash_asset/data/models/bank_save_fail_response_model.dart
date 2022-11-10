// To parse this JSON data, do
//
//     final bankSaveFailResponseModel = bankSaveFailResponseModelFromJson(jsonString);

import 'dart:convert';

BankSaveFailResponseModel bankSaveFailResponseModelFromJson(String str) =>
    BankSaveFailResponseModel.fromJson(json.decode(str));

String bankSaveFailResponseModelToJson(BankSaveFailResponseModel data) =>
    json.encode(data.toJson());

class BankSaveFailResponseModel {
  BankSaveFailResponseModel({
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

  factory BankSaveFailResponseModel.fromJson(Map<String, dynamic> json) =>
      BankSaveFailResponseModel(
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

  static const tBankSaveFailResponse = {
    "type": "test error type",
    "title": "test error title",
    "status": 400,
    "detail": "test error detail",
    "instance": "test error instance"
  };
}
