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
    required double newAsset,
    required double currentValue,
    required double change,
  }) : super(
          newAsset: newAsset,
          currentValue: currentValue,
          change: change,
        );

  factory Assets.fromJson(Map<String, dynamic> json) => Assets(
        newAsset: double.tryParse(json["newAsset"].toString()) ?? 0,
        currentValue: double.tryParse(json["currentValue"].toString()) ?? 0,
        change: double.tryParse(json["change"].toString()) ?? 0,
      );
}

class Liabilities extends LiabilitiesEntity {
  const Liabilities({
    required double newLiability,
    required double currentValue,
    required double change,
  }) : super(
          newLiability: newLiability,
          currentValue: currentValue,
          change: change,
        );

  factory Liabilities.fromJson(Map<String, dynamic> json) => Liabilities(
        newLiability: double.tryParse(json["newLiability"].toString()) ?? 1,
        currentValue: double.tryParse(json["currentValue"].toString()) ?? 1,
        change: double.tryParse(json["change"].toString()) ?? 1,
      );
}

class TotalNetWorth extends TotalNetWorthEntity {
  const TotalNetWorth({
    required double currentValue,
    required double change,
  }) : super(
          currentValue: currentValue,
          change: change,
        );

  factory TotalNetWorth.fromJson(Map<String, dynamic> json) => TotalNetWorth(
        currentValue: double.tryParse(json["currentValue"].toString()) ?? 0,
        change: double.tryParse(json["change"].toString()) ?? 0,
      );
}
