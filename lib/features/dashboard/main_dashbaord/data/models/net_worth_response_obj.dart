import 'package:wmd/features/dashboard/main_dashbaord/domain/entities/net_worth_entity.dart';

class NetWorthResponseObj extends NetWorthEntity {
  const NetWorthResponseObj({
    required TotalNetWorth totalNetWorth,
    required Assets assets,
    required Liabilities liabilities,
    required int durationInDays,
  }) : super(
          totalNetWorth: totalNetWorth,
          assets: assets,
          liabilities: liabilities,
          durationInDays: durationInDays,
        );

  factory NetWorthResponseObj.fromJson(Map<String, dynamic> json) =>
      NetWorthResponseObj(
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

  static const NetWorthResponseObj tNetWorthResponseObj = NetWorthResponseObj(
      totalNetWorth: TotalNetWorth(currentValue: 0, change: 0),
      assets: Assets(newAsset: 0, currentValue: 0, change: 0),
      liabilities: Liabilities(newLiability: 0, currentValue: 0, change: 0),
      durationInDays: 0);
}

class Assets extends AssetsEntity {
  const Assets({
    required int newAsset,
    required int currentValue,
    required int change,
  }) : super(
          newAsset: newAsset,
          currentValue: currentValue,
          change: change,
        );

  factory Assets.fromJson(Map<String, dynamic> json) => Assets(
        newAsset: json["newAsset"] ?? 0,
        currentValue: json["currentValue"] ?? 0,
        change: json["change"] ?? 0,
      );
}

class Liabilities extends LiabilitiesEntity {
  const Liabilities({
    required int newLiability,
    required int currentValue,
    required int change,
  }) : super(
          newLiability: newLiability,
          currentValue: currentValue,
          change: change,
        );

  factory Liabilities.fromJson(Map<String, dynamic> json) => Liabilities(
        newLiability: json["newLiability"] ?? 1,
        currentValue: json["currentValue"] ?? 1,
        change: json["change"] ?? 1,
      );
}

class TotalNetWorth extends TotalNetWorthEntity {
  const TotalNetWorth({
    required int currentValue,
    required int change,
  }) : super(
          currentValue: currentValue,
          change: change,
        );

  factory TotalNetWorth.fromJson(Map<String, dynamic> json) => TotalNetWorth(
        currentValue: json["currentValue"] ?? 0,
        change: json["change"] ?? 0,
      );
}
