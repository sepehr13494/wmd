import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_real_estate/domain/repositories/real_estate_repository.dart';
import 'package:wmd/features/add_assets/core/data/models/country.dart';
import 'package:wmd/features/add_assets/core/data/models/currency.dart';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';

class AddRealEstateUseCase extends UseCase<AddAsset, Map<String, dynamic>> {
  final RealEstateRepository realEstateRepository;

  AddRealEstateUseCase(this.realEstateRepository);
  @override
  Future<Either<Failure, AddAsset>> call(Map<String, dynamic> params) async {
    try {
      return await realEstateRepository
          .postRealEstate(getAddRealStateObj(params));
    } catch (e) {
      debugPrint("AddRealEstateUseCase catch : ${e.toString()}");
      return const Left(AppFailure(message: "Something went wrong!"));
    }
  }

  static AddRealEstateParams getAddRealStateObj(Map<String, dynamic> params) {
    final acquisitionCostPerUnit =
        params['acquisitionCostPerUnit'].toString().replaceAll(',', '');
    final marketValue = params['marketValue'].toString().replaceAll(',', '');

    final newMap = {
      ...params,
      "acquisitionCostPerUnit": acquisitionCostPerUnit,
      "marketValue": marketValue,
    };

    return AddRealEstateParams.fromJson(newMap);
  }
}

class AddRealEstateParams extends Equatable {
  const AddRealEstateParams({
    required this.name,
    required this.realEstateType,
    this.address,
    required this.noOfUnits,
    required this.country,
    required this.currencyCode,
    required this.acquisitionCostPerUnit,
    required this.ownershipPercentage,
    this.marketValue,
    required this.acquisitionDate,
    this.valuationDate,
  });

  final String name;
  final String realEstateType;
  final String? address;
  final int noOfUnits;
  final String country;
  final String currencyCode;
  final double acquisitionCostPerUnit;
  final double ownershipPercentage;
  final double? marketValue;
  final DateTime acquisitionDate;
  final DateTime? valuationDate;

  factory AddRealEstateParams.fromJson(Map<String, dynamic> json) =>
      AddRealEstateParams(
        name: json["name"],
        realEstateType: json["realEstateType"],
        address: json["address"],
        noOfUnits: json["noOfUnits"] != null
            ? int.tryParse(json["noOfUnits"])
            : json["noOfUnits"],
        country: (json["country"] as Country).name,
        currencyCode: (json["currencyCode"] as Currency).symbol,
        acquisitionCostPerUnit: json["acquisitionCostPerUnit"] != null
            ? double.tryParse(json["acquisitionCostPerUnit"])
            : json["acquisitionCostPerUnit"],
        ownershipPercentage: json["ownershipPercentage"] != null
            ? double.tryParse(json["ownershipPercentage"])
            : json["ownershipPercentage"],
        marketValue: json["marketValue"] != null
            ? double.tryParse(json["marketValue"])
            : json["marketValue"],
        acquisitionDate: DateTime.parse(json["acquisitionDate"].toString()),
        valuationDate: json["valuationDate"] != null
            ? DateTime.parse(json["valuationDate"].toString())
            : json["valuationDate"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "realEstateType": realEstateType,
        "address": address,
        "noOfUnits": noOfUnits,
        "country": country,
        "currencyCode": currencyCode,
        "acquisitionCostPerUnit": acquisitionCostPerUnit,
        "ownershipPercentage": ownershipPercentage,
        "valuePerUnit": marketValue,
        "acquisitionDate": acquisitionDate.toIso8601String(),
        "valuationDate": valuationDate?.toIso8601String()
      };

  static final tAddRealEstateMap = {
    "name": "investmentName",
    "realEstateType": "Residential",
    "address": "test",
    "noOfUnits": "2",
    "country": Country(name: "USA", countryName: "USA"),
    "currencyCode": Currency(name: "USD", symbol: "USD"),
    "acquisitionCostPerUnit": "10000",
    "ownershipPercentage": "50",
    "marketValue": "30000",
    "acquisitionDate": DateTime.parse('2022-10-05T21:00:00.000Z'),
    "valuationDate": DateTime.parse('2022-10-05T21:00:00.000Z'),
  };

  static final tAddRealEstateParams = AddRealEstateParams(
      name: "investmentName",
      realEstateType: "Residential",
      address: "test",
      noOfUnits: 2,
      country: "USA",
      currencyCode: "USD",
      acquisitionCostPerUnit: 10000,
      ownershipPercentage: 50,
      marketValue: 30000,
      acquisitionDate: DateTime.parse('2022-10-05T21:00:00.000Z'),
      valuationDate: DateTime.parse('2022-10-05T21:00:00.000Z'));

  @override
  List<Object?> get props => [
        name,
        realEstateType,
        address,
        noOfUnits,
        country,
        currencyCode,
        acquisitionCostPerUnit,
        ownershipPercentage,
        marketValue,
        acquisitionDate,
        valuationDate
      ];
}
