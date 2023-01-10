import 'package:wmd/features/asset_detail/core/data/models/get_detail_response.dart';

import '../../domain/entity/real_estate_entity.dart';

class RealEstateResponse extends RealEstateEntity implements GetDetailResponse {
  const RealEstateResponse({
    required String name,
    required String realEstateType,
    required String address,
    required double noOfUnits,
    required double acquisitionCostPerUnit,
    required DateTime acquisitionDate,
    required double ownershipPercentage,
    required double marketValue,
    required DateTime valuationDate,
    required DateTime? asOfDate,
    required String id,
    required double type,
    required bool isActive,
    required String country,
    required String region,
    required String currencyCode,
    required double holdings,
    required double portfolioContribution,
  }) : super(
          name: name,
          realEstateType: realEstateType,
          address: address,
          noOfUnits: noOfUnits,
          acquisitionCostPerUnit: acquisitionCostPerUnit,
          acquisitionDate: acquisitionDate,
          ownershipPercentage: ownershipPercentage,
          marketValue: marketValue,
          valuationDate: valuationDate,
          asOfDate: asOfDate,
          id: id,
          type: type,
          isActive: isActive,
          country: country,
          region: region,
          currencyCode: currencyCode,
          holdings: holdings,
          portfolioContribution: portfolioContribution,
        );

  factory RealEstateResponse.fromJson(Map<String, dynamic> json) {
    return RealEstateResponse(
      name: json['name'] ?? '',
      realEstateType: json['realEstateType'] ?? '',
      address: json['address'] ?? '',
      noOfUnits: double.tryParse(json['noOfUnits'].toString()) ?? 0,
      acquisitionCostPerUnit:
          double.tryParse(json['acquisitionCostPerUnit'].toString()) ?? 0,
      acquisitionDate: DateTime.parse(json["acquisitionDate"] ??
          DateTime.fromMillisecondsSinceEpoch(0).toIso8601String()),
      ownershipPercentage:
          double.tryParse(json['ownershipPercentage'].toString()) ?? 0,
      holdings: double.tryParse(json['holdings'].toString()) ?? 0,
      portfolioContribution:
          double.tryParse(json['portfolioContribution'].toString()) ?? 0,
      marketValue: double.tryParse(json['marketValue'].toString()) ?? 0,
      valuationDate: DateTime.parse(json["valuationDate"] ??
          DateTime.fromMillisecondsSinceEpoch(0).toIso8601String()),
      asOfDate:
          json["asOfDate"] == null ? null : DateTime.parse(json["asOfDate"]),
      id: json['id'] ?? '',
      type: double.tryParse(json["type"].toString()) ?? 0,
      isActive: json['isActive'] ?? '',
      country: json['country'] ?? '',
      region: json['region'] ?? '',
      currencyCode: json['currencyCode'] ?? '',
    );
  }
}
