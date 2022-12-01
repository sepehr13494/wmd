import 'package:equatable/equatable.dart';

class RealEstateEntity extends Equatable {
  final String name;
  final String realEstateType;
  final String address;
  final double noOfUnits;
  final double acquisitionCostPerUnit;
  final String acquisitionDate;
  final double ownershipPercentage;
  final String marketValue;
  final String valuationDate;
  final String id;
  final String type;
  final bool isActive;
  final String country;
  final String region;
  final String currencyCode;

  const RealEstateEntity({
    required this.name,
    required this.realEstateType,
    required this.address,
    required this.noOfUnits,
    required this.acquisitionCostPerUnit,
    required this.acquisitionDate,
    required this.ownershipPercentage,
    required this.marketValue,
    required this.valuationDate,
    required this.id,
    required this.type,
    required this.isActive,
    required this.country,
    required this.region,
    required this.currencyCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'realEstateType': realEstateType,
      'address': address,
      'noOfUnits': noOfUnits,
      'acquisitionCostPerUnit': acquisitionCostPerUnit,
      'acquisitionDate': acquisitionDate,
      'ownershipPercentage': ownershipPercentage,
      'marketValue': marketValue,
      'valuationDate': valuationDate,
      'id': id,
      'type': type,
      'isActive': isActive,
      'country': country,
      'region': region,
      'currencyCode': currencyCode,
    };
  }

  @override
  List<Object?> get props => [
        name,
        realEstateType,
        address,
        noOfUnits,
        acquisitionCostPerUnit,
        acquisitionDate,
        ownershipPercentage,
        marketValue,
        valuationDate,
        id,
        type,
        isActive,
        country,
        region,
        currencyCode,
      ];
}
