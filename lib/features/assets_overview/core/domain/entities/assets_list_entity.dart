import 'package:equatable/equatable.dart';

class AssetList extends Equatable{
  const AssetList({
    required this.assetId,
    required this.currency,
    required this.assetName,
    required this.subType,
    required this.currentValue,
    required this.inceptionToDate,
    required this.yearToDate,
    required this.geography,
    required this.type,
  });

  final String assetId;
  final String currency;
  final String assetName;
  final dynamic subType;
  final double currentValue;
  final double inceptionToDate;
  final double yearToDate;
  final String geography;
  final String type;

  Map<String, dynamic> toJson() => {
    "assetId": assetId,
    "currency": currency,
    "assetName": assetName,
    "subType": subType,
    "currentValue": currentValue,
    "inceptionToDate": inceptionToDate,
    "yearToDate": yearToDate,
    "geography": geography,
    "type": type,
  };

  @override
  List<Object?> get props => [
    assetId,
    currency,
    assetName,
    subType,
    currentValue,
    inceptionToDate,
    yearToDate,
    geography,
    type,
  ];
  
  String get assetNameFixed => assetName.replaceAll(RegExp(r"\s+"), " ");
}
