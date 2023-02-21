import 'package:equatable/equatable.dart';

class GetAssetsGeographyEntity  extends Equatable{
    const GetAssetsGeographyEntity({
        required this.geography,
        required this.totalAmount,
        required this.assetList,
        required this.yearToDate,
        required this.inceptionToDate,
    });

    final String geography;
    final double totalAmount;
    final List<AssetList> assetList;
    final double yearToDate;
    final double inceptionToDate;

    Map<String, dynamic> toJson() => {
        "geography": geography,
        "totalAmount": totalAmount,
        "assetList": List<dynamic>.from(assetList.map((x) => x.toJson())),
        "yearToDate": yearToDate,
        "inceptionToDate": inceptionToDate,
    };

    @override
    List<Object?> get props => [
        geography,
        totalAmount,
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
        required this.type,
    });

    final String assetId;
    final String assetName;
    final double currentValue;
    final double inceptionToDate;
    final double yearToDate;
    final String type;

    factory AssetList.fromJson(Map<String, dynamic> json) => AssetList(
        assetId: json["assetId"],
        assetName: json["assetName"],
        currentValue: json["currentValue"],
        inceptionToDate: json["inceptionToDate"],
        yearToDate: json["yearToDate"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "assetId": assetId,
        "assetName": assetName,
        "currentValue": currentValue,
        "inceptionToDate": inceptionToDate,
        "yearToDate": yearToDate,
        "type": type,
    };

  @override
  List<Object?> get props => [
      assetId,
      assetName,
      currentValue,
      inceptionToDate,
      yearToDate,
      type,
  ];
}
