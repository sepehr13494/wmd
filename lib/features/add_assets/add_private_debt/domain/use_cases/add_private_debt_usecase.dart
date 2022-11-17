import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/features/add_assets/add_private_debt/domain/repositories/private_debt_repository.dart';
import 'package:wmd/features/add_assets/core/data/models/country.dart';
import 'package:wmd/features/add_assets/core/data/models/currency.dart';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';

class AddPrivateDebtUseCase extends UseCase<AddAsset, Map<String, dynamic>> {
  final PrivateDebtRepository privateDebtRepository;
  final LocalStorage localStorage;

  AddPrivateDebtUseCase(this.privateDebtRepository, this.localStorage);
  @override
  Future<Either<Failure, AddAsset>> call(Map<String, dynamic> params) async {
    try {
      final ownerId = localStorage.getOwnerId();
      final investmentAmount =
          params['investmentAmount'].toString().replaceAll(',', '');
      final marketValue = params['marketValue'].toString().replaceAll(',', '');
      final newMap = {
        ...params,
        "owner": ownerId,
        "investmentAmount": investmentAmount,
        "marketValue": marketValue
      };

      final privateDebtAssetParam = AddPrivateDebtParams.fromJson(newMap);
      return await privateDebtRepository.postPrivateDebt(privateDebtAssetParam);
    } catch (e) {
      debugPrint("AddPrivateEquityUseCase catch : ${e.toString()}");
      return const Left(AppFailure(message: "Something went wrong!"));
    }
  }
}

AddPrivateDebtParams addPrivateDebtParamsFromJson(String str) =>
    AddPrivateDebtParams.fromJson(json.decode(str));

String addPrivateDebtParamsToJson(AddPrivateDebtParams data) =>
    json.encode(data.toJson());

class AddPrivateDebtParams extends Equatable {
  const AddPrivateDebtParams({
    this.isActive,
    required this.investmentName,
    required this.country,
    required this.currencyCode,
    required this.investmentAmount,
    required this.marketValue,
    required this.investmentDate,
    required this.valuationDate,
    this.wealthManager,
    required this.owner,
  });

  final bool? isActive;
  final String investmentName;
  final String country;
  final String currencyCode;
  final double investmentAmount;
  final double marketValue;
  final DateTime investmentDate;
  final DateTime valuationDate;
  final String? wealthManager;
  final String owner;

  factory AddPrivateDebtParams.fromJson(Map<String, dynamic> json) =>
      AddPrivateDebtParams(
        isActive: json["isActive"],
        investmentName: json["investmentName"],
        country: (json["country"] as Country).countryName,
        currencyCode: (json["currencyCode"] as Currency).symbol,
        investmentAmount: json["investmentAmount"] != null
            ? double.tryParse(json["investmentAmount"])
            : json["investmentAmount"],
        marketValue: json["marketValue"] != null
            ? double.tryParse(json["marketValue"])
            : json["marketValue"],
        investmentDate: DateTime.parse(json["investmentDate"]),
        valuationDate: DateTime.parse(json["valuationDate"]),
        wealthManager: json["wealthManager"],
        owner: json["owner"],
      );

  Map<String, dynamic> toJson() => {
        "isActive": isActive,
        "investmentName": investmentName,
        "country": country,
        "currencyCode": currencyCode,
        "investmentAmount": investmentAmount,
        "marketValue": marketValue,
        "investmentDate": investmentDate.toIso8601String(),
        "valuationDate": valuationDate.toIso8601String(),
        "wealthManager": wealthManager,
        "owner": owner,
      };

  static final tAddPrivateDebtMap = {
    "investmentName": "investmentName",
    "country": Country(name: "USA", countryName: "USA"),
    "currencyCode": Currency(name: "USD", symbol: "USD"),
    "investmentAmount": '100,000',
    "marketValue": '100,000',
    "investmentDate": "2022-10-05T21:00:00.000Z",
    "valuationDate": "2022-10-05T21:00:00.000Z",
    "wealthManager": "wealthManager",
    "owner": "ownerId"
  };

  static final tAddPrivateDebtParams = AddPrivateDebtParams(
      investmentName: "investmentName",
      country: "USA",
      currencyCode: "USD",
      investmentAmount: 100000.0,
      marketValue: 100000.0,
      investmentDate: DateTime.parse('2022-10-05T21:00:00.000Z'),
      valuationDate: DateTime.parse('2022-10-05T21:00:00.000Z'),
      owner: "ownerId",
      wealthManager: "wealthManager");

  @override
  List<Object?> get props => [
        isActive,
        investmentName,
        country,
        currencyCode,
        investmentAmount,
        marketValue,
        investmentDate,
        valuationDate,
        wealthManager,
        owner
      ];
}
