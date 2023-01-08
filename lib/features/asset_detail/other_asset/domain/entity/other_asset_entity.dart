import 'package:equatable/equatable.dart';

class OtherAssetEntity extends Equatable {
  const OtherAssetEntity({
    required this.name,
    required this.category,
    required this.units,
    required this.acquisitionCost,
    required this.acquisitionDate,
    required this.ownerShip,
    required this.valuePerUnit,
    required this.currentDayValue,
    required this.yearToDate,
    required this.inceptionToDate,
    required this.wealthManager,
    required this.valuationDate,
    required this.id,
    required this.type,
    required this.isActive,
    required this.asOfDate,
    required this.country,
    required this.region,
    required this.currencyCode,
    required this.portfolioContribution,
    required this.holdings,
  });

  final String name;
  final String wealthManager;
  final String category;
  final double units;
  final double acquisitionCost;
  final DateTime acquisitionDate;
  final DateTime valuationDate;
  final double ownerShip;
  final double valuePerUnit;
  final double currentDayValue;
  final String id;
  final String type;
  final bool isActive;
  final String country;
  final String region;
  final String currencyCode;
  final double portfolioContribution;
  final double holdings;
  final double yearToDate;
  final double inceptionToDate;
  final DateTime asOfDate;

  Map<String, dynamic> toJson() => {
        "name": name,
        "wealthManager": wealthManager,
        "category": category,
        "units": units,
        "acquisitionCost": acquisitionCost,
        "acquisitionDate": acquisitionDate.toIso8601String(),
        "valuationDate": valuationDate.toIso8601String(),
        "ownerShip": ownerShip,
        "valuePerUnit": valuePerUnit,
        "currentDayValue": currentDayValue,
        "id": id,
        "type": type,
        "isActive": isActive,
        "country": country,
        "region": region,
        "currencyCode": currencyCode,
        "portfolioContribution": portfolioContribution,
        "holdings": holdings,
        "yearToDate": yearToDate,
        "inceptionToDate": inceptionToDate,
        "asOfDate": asOfDate.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        name,
        category,
        units,
        acquisitionCost,
        acquisitionDate,
        ownerShip,
        valuePerUnit,
        currentDayValue,
        yearToDate,
        inceptionToDate,
        wealthManager,
        valuationDate,
        id,
        type,
        isActive,
        asOfDate,
        country,
        region,
        currencyCode,
        portfolioContribution,
        holdings,
      ];
}
