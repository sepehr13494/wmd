import 'package:equatable/equatable.dart';

class NetWorthEntity extends Equatable{
  const NetWorthEntity({
    required this.totalNetWorth,
    required this.assets,
    required this.liabilities,
    required this.durationInDays,
    required this.lastUpdated,
  });

  final TotalNetWorthEntity totalNetWorth;
  final AssetsEntity assets;
  final LiabilitiesEntity liabilities;
  final int durationInDays;
  final String lastUpdated;

  Map<String, dynamic> toJson() => {
    "totalNetWorth": totalNetWorth.toJson(),
    "assets": assets.toJson(),
    "liabilities": liabilities.toJson(),
    "durationInDays": durationInDays,
    "lastUpdated": lastUpdated,
  };

  @override
  List<Object?> get props => [
    totalNetWorth,
    assets,
    liabilities,
    durationInDays,
    lastUpdated,
  ];

}

class AssetsEntity extends Equatable{
  const AssetsEntity({
    required this.newAssetCount,
    required this.currentValue,
    required this.newAssetValue,
    required this.change,
    required this.changePercentage,
    required this.ytd,
    required this.itd,
  });

  final double newAssetCount;
  final double currentValue;
  final double newAssetValue;
  final double change;
  final double changePercentage;
  final double ytd;
  final double itd;

  @override
  List<Object?> get props => [
    newAssetCount,
    currentValue,
    newAssetValue,
    change,
    changePercentage,
    ytd,
    itd,
  ];

  Map<String, dynamic> toJson() =>
      {
        "newAssetCount": newAssetCount,
        "currentValue": currentValue,
        "newAssetValue": newAssetValue,
        "change": change,
        "changePercentage": changePercentage,
        "ytd": ytd,
        "itd": itd,
      };
}

class LiabilitiesEntity extends Equatable{
  const LiabilitiesEntity({
    required this.newLiabilityCount,
    required this.currentValue,
    required this.newLiabilityValue,
    required this.change,
    required this.ytd,
    required this.itd,
  });

  final double newLiabilityCount;
  final double currentValue;
  final double newLiabilityValue;
  final double change;
  final double ytd;
  final double itd;

  @override
  List<Object?> get props => [
    newLiabilityCount,
    currentValue,
    newLiabilityValue,
    change,
    ytd,
    itd,
  ];

  Map<String, dynamic> toJson() =>
      {
        "newLiabilityCount": newLiabilityCount,
        "currentValue": currentValue,
        "newLiabilityValue": newLiabilityValue,
        "change": change,
        "ytd": ytd,
        "itd": itd,
      };
}

class TotalNetWorthEntity extends Equatable{
  const TotalNetWorthEntity({
    required this.currentValue,
    required this.change,
  });

  final double currentValue;
  final double change;

  @override
  List<Object?> get props => [
    currentValue,
    change,
  ];

  Map<String, dynamic> toJson() =>
      {
        "currentValue": currentValue,
        "change": change,
      };
}
