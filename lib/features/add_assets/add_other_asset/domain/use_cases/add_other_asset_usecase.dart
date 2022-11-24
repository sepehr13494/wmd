import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_other_asset/domain/repositories/other_asset_repository.dart';
import 'package:wmd/features/add_assets/core/data/models/country.dart';
import 'package:wmd/features/add_assets/core/data/models/currency.dart';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';

class AddOtherAssetUseCase extends UseCase<AddAsset, Map<String, dynamic>> {
  final OtherAssetRepository otherAssetRepository;

  AddOtherAssetUseCase(this.otherAssetRepository);
  @override
  Future<Either<Failure, AddAsset>> call(Map<String, dynamic> params) async {
    try {
      final acquisitionCost =
          params['acquisitionCost'].toString().replaceAll(',', '');
      final valuePerUnit =
          params['valuePerUnit'].toString().replaceAll(',', '');
      final currentDayValue =
          params['currentDayValue'].toString().replaceAll(',', '');

      final newMap = {
        ...params,
        "acquisitionCost": acquisitionCost,
        "valuePerUnit": valuePerUnit,
        "currentDayValue": currentDayValue,
      };

      final privateDebtAssetParam = AddOtherAssetParams.fromJson(newMap);
      return await otherAssetRepository.postOtherAsset(privateDebtAssetParam);
    } catch (e) {
      debugPrint("AddOtherAssetUseCase catch : ${e.toString()}");
      return const Left(AppFailure(message: "Something went wrong!"));
    }
  }
}

class AddOtherAssetParams extends Equatable {
  const AddOtherAssetParams({
    required this.name,
    this.wealthManager,
    required this.assetType,
    required this.country,
    required this.currencyCode,
    required this.units,
    required this.acquisitionCost,
    required this.acquisitionDate,
    this.valuationDate,
    required this.ownerShip,
    this.valuePerUnit,
    this.currentDayValue,
  });

  final String name;
  final String? wealthManager;
  final String assetType;
  final String country;
  final String currencyCode;
  final int units;
  final double acquisitionCost;
  final DateTime acquisitionDate;
  final DateTime? valuationDate;
  final double ownerShip;
  final double? valuePerUnit;
  final double? currentDayValue;

  factory AddOtherAssetParams.fromJson(Map<String, dynamic> json) =>
      AddOtherAssetParams(
        name: json["name"],
        wealthManager: json["wealthManager"],
        assetType: json["assetType"],
        country: (json["country"] as Country).name,
        currencyCode: (json["currencyCode"] as Currency).symbol,
        units:
            json["units"] != null ? int.tryParse(json["units"]) : json["units"],
        acquisitionCost: json["acquisitionCost"] != null
            ? double.tryParse(json["acquisitionCost"])
            : json["acquisitionCost"],
        acquisitionDate: DateTime.parse(json["acquisitionDate"].toString()),
        valuationDate: DateTime.parse(json["valuationDate"].toString()),
        ownerShip: json["ownerShip"] != null
            ? double.tryParse(json["ownerShip"])
            : json["ownerShip"],
        valuePerUnit: json["valuePerUnit"] != null
            ? double.tryParse(json["valuePerUnit"])
            : json["valuePerUnit"],
        currentDayValue: json["currentDayValue"] != null
            ? double.tryParse(json["currentDayValue"])
            : json["currentDayValue"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "wealthManager": wealthManager,
        "assetType": assetType,
        "country": country,
        "currencyCode": currencyCode,
        "units": units,
        "acquisitionCost": acquisitionCost,
        "acquisitionDate": acquisitionDate.toIso8601String(),
        "valuationDate": valuationDate?.toIso8601String(),
        "ownerShip": ownerShip,
        "valuePerUnit": valuePerUnit,
        "currentDayValue": currentDayValue
      };

  static final tAddOtherAssetMap = {
    "name": "investmentName",
    "wealthManager": "Abbot Downing",
    "assetType": "Painting",
    "country": Country(name: "USA", countryName: "USA"),
    "currencyCode": Currency(name: "USD", symbol: "USD"),
    "units": 1,
    "acquisitionCost": "123",
    "acquisitionDate": DateTime.parse('2022-10-05T21:00:00.000Z'),
    "valuationDate": DateTime.parse('2022-10-05T21:00:00.000Z'),
    "ownerShip": "50",
    "valuePerUnit": "30000",
    "currentDayValue": "30000"
  };

  static final tAddOtherAssetParams = AddOtherAssetParams(
    name: "investmentName",
    wealthManager: "Abbot Downing",
    assetType: "Painting",
    country: "USA",
    currencyCode: "USD",
    units: 1,
    acquisitionCost: 123,
    acquisitionDate: DateTime.parse('2022-10-05T21:00:00.000Z'),
    valuationDate: DateTime.parse('2022-10-05T21:00:00.000Z'),
    ownerShip: 50,
    valuePerUnit: 30000,
    currentDayValue: 30000,
  );

  @override
  List<Object?> get props => [
        name,
        wealthManager,
        assetType,
        country,
        currencyCode,
        units,
        acquisitionCost,
        acquisitionDate,
        valuationDate,
        ownerShip,
        valuePerUnit,
        currentDayValue
      ];
}
