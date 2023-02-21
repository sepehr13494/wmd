import 'package:equatable/equatable.dart';
import 'package:wmd/features/assets_overview/core/domain/entities/assets_overview_base_model.dart';

import '../../../core/domain/entities/assets_list_entity.dart';

class AssetsOverviewEntity extends AssetsOverviewBaseModel{
  const AssetsOverviewEntity({
    required this.type,
    required this.subType,
    required double totalAmount,
    required List<AssetList> assetList,
    required double yearToDate,
    required double inceptionToDate,
  }) : super(
    totalAmount: totalAmount,
    assetList: assetList,
    yearToDate: yearToDate,
    inceptionToDate: inceptionToDate,
  );

  final String type;
  final String? subType;

  Map<String, dynamic> toJson() => {
    "type": type,
    "subType": subType,
    "totalAmount": totalAmount,
    "assetList": List<dynamic>.from(assetList.map((x) => x.toJson())),
    "yearToDate": yearToDate,
    "inceptionToDate": inceptionToDate,
  };

  @override
  List<Object?> get props => [
    type,
    subType,
    totalAmount,
    assetList,
    yearToDate,
    inceptionToDate,
  ];
}