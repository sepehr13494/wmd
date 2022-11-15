import 'package:equatable/equatable.dart';

class NetWorthEntity extends Equatable{
  const NetWorthEntity({
    required this.totalNetWorth,
    required this.assets,
    required this.liabilities,
    required this.durationInDays,
  });

  final TotalNetWorthEntity totalNetWorth;
  final AssetsEntity assets;
  final LiabilitiesEntity liabilities;
  final int durationInDays;

  @override
  List<Object?> get props => [
    totalNetWorth,
    assets,
    liabilities,
    durationInDays,
  ];

}

class AssetsEntity extends Equatable{
  const AssetsEntity({
    required this.newAsset,
    required this.currentValue,
    required this.change,
  });

  final double newAsset;
  final double currentValue;
  final double change;

  @override
  List<Object?> get props => [
    newAsset,
    currentValue,
    change,
  ];

  Map<String, dynamic> toJson() =>
      {
        "newAsset": newAsset,
        "currentValue": currentValue,
        "change": change,
      };
}

class LiabilitiesEntity extends Equatable{
  const LiabilitiesEntity({
    required this.newLiability,
    required this.currentValue,
    required this.change,
  });

  final double newLiability;
  final double currentValue;
  final double change;

  @override
  List<Object?> get props => [
    newLiability,
    currentValue,
    change,
  ];

  Map<String, dynamic> toJson() =>
      {
        "newLiability": newLiability,
        "currentValue": currentValue,
        "change": change,
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
