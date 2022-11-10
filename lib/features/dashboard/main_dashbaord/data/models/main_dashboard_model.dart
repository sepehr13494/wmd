// To parse this JSON data, do
//
//     final netWorthObj = netWorthObjFromJson(jsonString);

import 'dart:convert';

NetWorthObj netWorthObjFromJson(String str) => NetWorthObj.fromJson(json.decode(str));

String netWorthObjToJson(NetWorthObj data) => json.encode(data.toJson());

class NetWorthObj {
  NetWorthObj({
    required this.totalNetWorth,
    required this.assets,
    required this.liabilities,
    required this.durationInDays,
  });

  TotalNetWorth totalNetWorth;
  Assets assets;
  Liabilities liabilities;
  int durationInDays;

  factory NetWorthObj.fromJson(Map<String, dynamic> json) => NetWorthObj(
    totalNetWorth: TotalNetWorth.fromJson(json["totalNetWorth"]),
    assets: Assets.fromJson(json["assets"]),
    liabilities: Liabilities.fromJson(json["liabilities"]),
    durationInDays: json["durationInDays"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "totalNetWorth": totalNetWorth.toJson(),
    "assets": assets.toJson(),
    "liabilities": liabilities.toJson(),
    "durationInDays": durationInDays,
  };
}

class Assets {
  Assets({
    required this.newAsset,
    required this.currentValue,
    required this.change,
  });

  int newAsset;
  int currentValue;
  int change;

  factory Assets.fromJson(Map<String, dynamic> json) => Assets(
    newAsset: json["newAsset"]??0,
    currentValue: json["currentValue"]??0,
    change: json["change"]??0,
  );

  Map<String, dynamic> toJson() => {
    "newAsset": newAsset,
    "currentValue": currentValue,
    "change": change,
  };
}

class Liabilities {
  Liabilities({
    required this.newLiability,
    required this.currentValue,
    required this.change,
  });

  int newLiability;
  int currentValue;
  int change;

  factory Liabilities.fromJson(Map<String, dynamic> json) => Liabilities(
    newLiability: json["newLiability"]??1,
    currentValue: json["currentValue"]??1,
    change: json["change"]??1,
  );

  Map<String, dynamic> toJson() => {
    "newLiability": newLiability,
    "currentValue": currentValue,
    "change": change,
  };
}

class TotalNetWorth {
  TotalNetWorth({
    required this.currentValue,
    required this.change,
  });

  int currentValue;
  int change;

  factory TotalNetWorth.fromJson(Map<String, dynamic> json) => TotalNetWorth(
    currentValue: json["currentValue"]??0,
    change: json["change"]??0,
  );

  Map<String, dynamic> toJson() => {
    "currentValue": currentValue,
    "change": change,
  };
}
