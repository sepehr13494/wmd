import 'package:equatable/equatable.dart';

class RealEstateEntity extends Equatable {
  final String name;
  final String realEstateType;
  final String address;
  final double noOfUnits;
  final double acquisitionCostPerUnit;
  final DateTime acquisitionDate;
  final double ownershipPercentage;
  final double marketValue;
  final DateTime valuationDate;
  final DateTime? asOfDate;
  final String id;
  final double type;
  final bool isActive;
  final String country;
  final String region;
  final String currencyCode;
  final double holdings;
  final double portfolioContribution;

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
    required this.asOfDate,
    required this.id,
    required this.type,
    required this.isActive,
    required this.country,
    required this.region,
    required this.currencyCode,
    required this.holdings,
    required this.portfolioContribution,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'realEstateType': realEstateType,
      'address': address,
      'noOfUnits': noOfUnits,
      'acquisitionCostPerUnit': acquisitionCostPerUnit,
      'acquisitionDate': acquisitionDate.toIso8601String(),
      'ownershipPercentage': ownershipPercentage,
      'marketValue': marketValue,
      'valuationDate': valuationDate.toIso8601String(),
      'asOfDate': asOfDate?.toIso8601String(),
      'id': id,
      'type': type,
      'isActive': isActive,
      'country': country,
      'region': region,
      'currencyCode': currencyCode,
      'holdings': holdings,
      'portfolioContribution': portfolioContribution,
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
        asOfDate,
        currencyCode,
        holdings,
        portfolioContribution,
      ];
}
