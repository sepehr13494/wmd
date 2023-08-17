import 'package:wmd/features/dashboard/main_dashbaord/domain/entities/net_worth_entity.dart';

class NetWorthResponseObj extends NetWorthEntity {
  const NetWorthResponseObj({
    required TotalNetWorth totalNetWorth,
    required Assets assets,
    required Liabilities liabilities,
    required int durationInDays,
    required String lastUpdated,
  }) : super(
          totalNetWorth: totalNetWorth,
          assets: assets,
          liabilities: liabilities,
          durationInDays: durationInDays,
          lastUpdated: lastUpdated,
        );

  factory NetWorthResponseObj.fromJson(Map<String, dynamic> json) =>
      NetWorthResponseObj(
        totalNetWorth: TotalNetWorth.fromJson(json["totalNetWorth"] ??
            const TotalNetWorth(currentValue: 0, change: 0).toJson()),
        assets: Assets.fromJson(json["assets"] ??
            const Assets(
                    newAssetCount: 0,
                    currentValue: 0,
                    newAssetValue: 0,
                    change: 0,
                    changePercentage: 0,
                    ytd: 0,
                    itd: 0)
                .toJson()),
        liabilities: Liabilities.fromJson(json["liabilities"] ??
            const Liabilities(
                    newLiabilityCount: 0,
                    currentValue: 0,
                    newLiabilityValue: 0,
                    change: 0,
                    ytd: 0,
                    itd: 0)
                .toJson()),
        durationInDays: json["durationInDays"] ?? 0,
        lastUpdated: json["lastUpdated"] ?? "2022-12-31T00:00:00",
      );

  static const NetWorthResponseObj tNetWorthResponseObj = NetWorthResponseObj(
      totalNetWorth: TotalNetWorth(currentValue: 0, change: 0),
      assets: Assets(
          newAssetCount: 0,
          currentValue: 0,
          newAssetValue: 0,
          change: 0,
          itd: 0,
          ytd: 0,
          changePercentage: 0),
      liabilities: Liabilities(
          newLiabilityCount: 0,
          currentValue: 0,
          newLiabilityValue: 0,
          change: 0,
          itd: 0,
          ytd: 0),
      durationInDays: 0,
      lastUpdated: "2022-12-31T00:00:00");
}

class Assets extends AssetsEntity {
  const Assets({
    required double newAssetCount,
    required double newAssetValue,
    required double currentValue,
    required double change,
    required double changePercentage,
    required double ytd,
    required double itd,
    double? unrealizedGainLoss,
  }) : super(
          newAssetCount: newAssetCount,
          newAssetValue: newAssetValue,
          currentValue: currentValue,
          change: change,
          changePercentage: changePercentage,
          ytd: ytd,
          itd: itd,
          unrealizedGainLoss: unrealizedGainLoss,
        );

  factory Assets.fromJson(Map<String, dynamic> json) => Assets(
        newAssetCount: double.tryParse(json["newAssetCount"].toString()) ?? 0,
        newAssetValue: double.tryParse(json["newAssetValue"].toString()) ?? 0,
        currentValue: double.tryParse(json["currentValue"].toString()) ?? 0,
        change: double.tryParse(json["change"].toString()) ?? 0,
        changePercentage:
            double.tryParse(json["changePercentage"].toString()) ?? 0,
        ytd: double.tryParse(json["ytd"].toString()) ?? 0,
        itd: double.tryParse(json["itd"].toString()) ?? 0,
        unrealizedGainLoss: json["unrealizedGainLoss"] != null
            ? double.tryParse(json["unrealizedGainLoss"].toString()) ?? 0
            : 0,
      );
}

class Liabilities extends LiabilitiesEntity {
  const Liabilities({
    required double newLiabilityCount,
    required double currentValue,
    required double newLiabilityValue,
    required double change,
    required double ytd,
    required double itd,
  }) : super(
          newLiabilityCount: newLiabilityCount,
          currentValue: currentValue,
          newLiabilityValue: newLiabilityValue,
          change: change,
          ytd: ytd,
          itd: itd,
        );

  factory Liabilities.fromJson(Map<String, dynamic> json) => Liabilities(
        newLiabilityCount:
            double.tryParse(json["newLiabilityCount"].toString()) ?? 1,
        currentValue: double.tryParse(json["currentValue"].toString()) ?? 1,
        newLiabilityValue:
            double.tryParse(json["newLiabilityValue"].toString()) ?? 1,
        change: double.tryParse(json["change"].toString()) ?? 1,
        ytd: double.tryParse(json["ytd"].toString()) ?? 1,
        itd: double.tryParse(json["itd"].toString()) ?? 1,
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
