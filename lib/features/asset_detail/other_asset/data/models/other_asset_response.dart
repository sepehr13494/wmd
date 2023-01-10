import 'package:wmd/features/asset_detail/core/data/models/get_detail_response.dart';
import '../../domain/entity/other_asset_entity.dart';

class OtherAssetResponse extends OtherAssetEntity implements GetDetailResponse {
  const OtherAssetResponse(
      {required super.name,
      required super.category,
      required super.units,
      required super.acquisitionCost,
      required super.acquisitionDate,
      required super.ownerShip,
      required super.valuePerUnit,
      required super.currentDayValue,
      required super.yearToDate,
      required super.inceptionToDate,
      required super.wealthManager,
      required super.valuationDate,
      required super.id,
      required super.type,
      required super.isActive,
      required super.asOfDate,
      required super.country,
      required super.region,
      required super.currencyCode,
      required super.portfolioContribution,
      required super.holdings});

  factory OtherAssetResponse.fromJson(Map<String, dynamic> json) =>
      OtherAssetResponse(
        wealthManager: json["wealthManager"] ?? '',
        valuationDate: DateTime.parse(json["valuationDate"]),
        asOfDate: DateTime.parse(json["asOfDate"]),
        id: json["id"],
        type: double.tryParse(json["type"].toString()) ?? 0,
        isActive: json["isActive"],
        country: json["country"],
        region: json["region"],
        currencyCode: json["currencyCode"],
        portfolioContribution:
            double.tryParse(json["portfolioContribution"].toString()) ?? 0,
        holdings: double.tryParse(json["holdings"].toString()) ?? 0,
        name: json["name"],
        category: json["category"],
        units: json["units"],
        acquisitionCost: json["acquisitionCost"],
        acquisitionDate: DateTime.parse(json["acquisitionDate"]),
        ownerShip: json["ownerShip"],
        valuePerUnit: json["valuePerUnit"],
        currentDayValue: json["currentDayValue"],
        yearToDate: json["yearToDate"].toDouble(),
        inceptionToDate: json["inceptionToDate"],
      );
}
// double.tryParse(json["investmentAmount"].toString()) ?? 0