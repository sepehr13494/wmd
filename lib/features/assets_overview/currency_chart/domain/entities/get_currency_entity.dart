import 'package:equatable/equatable.dart';

class GetCurrencyEntity extends Equatable{
    const GetCurrencyEntity({
        required this.currencyCode,
        required this.totalAmount,
        required this.assetList,
        required this.yearToDate,
        required this.inceptionToDate,
    });

    final String currencyCode;
    final double totalAmount;
    final List<AssetList> assetList;
    final double yearToDate;
    final double inceptionToDate;


    Map<String, dynamic> toJson() => {
        "currencyCode": currencyCode,
        "totalAmount": totalAmount,
        "assetList": List<dynamic>.from(assetList.map((x) => x.toJson())),
        "yearToDate": yearToDate,
        "inceptionToDate": inceptionToDate,
    };

  @override
  List<Object?> get props => [
      currencyCode,
      totalAmount,
      assetList,
      yearToDate,
      inceptionToDate,
  ];
}

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
}
