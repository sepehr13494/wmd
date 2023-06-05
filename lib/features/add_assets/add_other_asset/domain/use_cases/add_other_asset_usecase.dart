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
      return await otherAssetRepository
          .postOtherAsset(getAddOtherAssetObj(params));
    } catch (e) {
      debugPrint("AddOtherAssetUseCase catch : ${e.toString()}");
      return const Left(AppFailure(message: "Something went wrong!"));
    }
  }

  static AddOtherAssetParams getAddOtherAssetObj(Map<String, dynamic> params) {
    final acquisitionCost =
        params['acquisitionCost'].toString().replaceAll(',', '');
    final valuePerUnit = params['valuePerUnit'] != null
        ? params['valuePerUnit'].toString().replaceAll(',', '')
        : params['valuePerUnit'];
    final currentDayValue =
        params['currentDayValue'].toString().replaceAll(',', '');

    final newMap = {
      ...params,
      "acquisitionCost": acquisitionCost,
      "valuePerUnit": valuePerUnit,
      "currentDayValue": currentDayValue,
      "valuationDate": (params['valuationDate']) != null
          ? params['valuationDate']
          : DateTime.now(),
    };

    debugPrint(newMap.toString());

    return AddOtherAssetParams.fromJson(newMap);
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
  final DateTime? acquisitionDate;
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
        acquisitionDate: json["acquisitionDate"] != null
            ? DateTime.parse(json["acquisitionDate"].toString())
            : json["acquisitionDate"],
        valuationDate: json["valuationDate"] != null
            ? DateTime.parse(json["valuationDate"].toString())
            : json["valuationDate"],
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
        "acquisitionDate": acquisitionDate?.toUtc().toIso8601String(),
        "valuationDate": valuationDate?.toUtc().toIso8601String(),
        "ownerShip": ownerShip,
        "valuePerUnit": valuePerUnit,
        "currentDayValue": currentDayValue == 0 ? null : currentDayValue
      };

  static final tAddOtherAssetMap = {
    "name": "investmentName",
    "wealthManager": "Abbot Downing",
    "assetType": "Painting",
    "country": Country(name: "USA", countryName: "USA"),
    "currencyCode": Currency(name: "USD", symbol: "USD"),
    "units": "1",
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
    acquisitionCost: 123.0,
    acquisitionDate: DateTime.parse('2022-10-05T21:00:00.000Z'),
    valuationDate: DateTime.parse('2022-10-05T21:00:00.000Z'),
    ownerShip: 50.0,
    valuePerUnit: 30000.0,
    currentDayValue: 30000.0,
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
