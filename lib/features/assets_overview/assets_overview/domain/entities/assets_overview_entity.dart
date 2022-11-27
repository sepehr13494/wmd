import 'package:equatable/equatable.dart';

class AssetsOverviewEntity extends Equatable{
  const AssetsOverviewEntity({
    required this.type,
    required this.totalAmount,
    required this.assetList,
    required this.yearToDate,
    required this.inceptionToDate,
  });

  final String type;
  final double totalAmount;
  final List<AssetList> assetList;
  final double yearToDate;
  final double inceptionToDate;

  Map<String, dynamic> toJson() => {
    "type": type,
    "totalAmount": totalAmount,
    "assetList": List<dynamic>.from(assetList.map((x) => x.toJson())),
    "yearToDate": yearToDate,
    "inceptionToDate": inceptionToDate,
  };

  @override
  List<Object?> get props => [
    type,
    totalAmount,
    assetList,
    yearToDate,
    inceptionToDate,
  ];
}

class AssetList extends Equatable{
  const AssetList({
    required this.assetId,
    required this.assetName,
    required this.currentValue,
    required this.inceptionToDate,
    required this.yearToDate,
    required this.geography,
  });

  final String assetId;
  final String assetName;
  final double currentValue;
  final double inceptionToDate;
  final double yearToDate;
  final String geography;

  Map<String, dynamic> toJson() => {
    "assetId": assetId,
    "assetName": assetName,
    "currentValue": currentValue,
    "inceptionToDate": inceptionToDate,
    "yearToDate": yearToDate,
    "geography": geography,
  };

  @override
  List<Object?> get props => [
    assetId,
  ];
}
