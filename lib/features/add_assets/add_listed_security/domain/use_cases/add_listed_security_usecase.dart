import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_listed_security/domain/repositories/listed_security_repository.dart';
import 'package:wmd/features/add_assets/core/data/models/country.dart';
import 'package:wmd/features/add_assets/core/data/models/currency.dart';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';

class AddListedSecurityUseCase extends UseCase<AddAsset, Map<String, dynamic>> {
  final ListedSecurityRepository listedSecurityRepository;

  AddListedSecurityUseCase(this.listedSecurityRepository);
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
        "valuationDate": (params['valuationDate']) != null
            ? params['valuationDate']
            : DateTime.now(),
      };

      final privateDebtAssetParam = AddListedSecurityParams.fromJson(newMap);

      return await listedSecurityRepository
          .postListedSecurity(privateDebtAssetParam);
    } catch (e) {
      debugPrint("AddOtherAssetUseCase catch : ${e.toString()}");
      return const Left(AppFailure(message: "Something went wrong!"));
    }
  }
}

class AddListedSecurityParams extends Equatable {
  const AddListedSecurityParams({
    required this.securityName,
    required this.securityShortName,
    required this.tradedExchange,
    this.brokerName,
    required this.isin,
    required this.category,
    required this.country,
    required this.currencyCode,
    required this.investmentDate,
    required this.marketValue,
    required this.quantity,
    required this.totalCost,
    required this.maturityDate,
    required this.buyPricePerUnit,
    required this.valuationDate,
  });

  final String securityName;
  final String securityShortName;
  final String tradedExchange;
  final String? brokerName;
  final String isin;
  final String category;
  final String country;
  final String currencyCode;
  final DateTime investmentDate;
  final double marketValue;
  final double quantity;
  final double totalCost;
  final DateTime maturityDate;
  final double buyPricePerUnit;
  final DateTime valuationDate;

  factory AddListedSecurityParams.fromJson(Map<String, dynamic> json) =>
      AddListedSecurityParams(
        securityName: json["securityName"],
        securityShortName: json["securityShortName"],
        tradedExchange: json["tradedExchange"],
        brokerName: json["brokerName"],
        isin: json["isin"],
        category: json["category"],
        country: (json["country"] as Country).name,
        currencyCode: (json["currencyCode"] as Currency).symbol,
        investmentDate: json["investmentDate"],
        marketValue: json["marketValue"],
        quantity: json["quantity"],
        totalCost: json["totalCost"],
        maturityDate: json["maturityDate"],
        buyPricePerUnit: json["buyPricePerUnit"],
        valuationDate: json["valuationDate"],
      );

  Map<String, dynamic> toJson() => {
        "securityName": securityName,
        "securityShortName": securityShortName,
        "tradedExchange": tradedExchange,
        "brokerName": brokerName,
        "isin": isin,
        "category": category,
        "country": country,
        "currencyCode": currencyCode,
        "investmentDate": investmentDate.toIso8601String(),
        "marketValue": marketValue,
        "quantity": quantity,
        "totalCost": totalCost,
        "maturityDate": maturityDate.toIso8601String(),
        "buyPricePerUnit": buyPricePerUnit,
        "valuationDate": valuationDate.toIso8601String(),
      };

  static final tAddListedSecurityMap = {
    "securityName": "Test Security Asset",
    "securityShortName": "Test",
    "tradedExchange": "test",
    "brokerName": "Abbot Downing",
    "isin": "us209878",
    "category": "FixedIncome",
    "country": Country(name: "USA", countryName: "USA"),
    "currencyCode": Currency(name: "USD", symbol: "USD"),
    "investmentDate": DateTime.parse('2022-10-05T21:00:00.000Z'),
    "marketValue": "30000",
    "quantity": "3",
    "totalCost": "20000",
    "maturityDate": DateTime.parse('2022-10-05T21:00:00.000Z'),
    "buyPricePerUnit": "20000",
    "valuationDate": DateTime.parse('2022-10-05T21:00:00.000Z'),
  };

  static final tAddListedSecurityParams = AddListedSecurityParams(
    securityName: "Test Security Asset",
    securityShortName: "Test",
    tradedExchange: "test",
    brokerName: "Abbot Downing",
    isin: "us209878",
    category: "FixedIncome",
    country: "USA",
    currencyCode: "USD",
    investmentDate: DateTime.parse('2022-10-05T21:00:00.000Z'),
    marketValue: 30000,
    quantity: 3,
    totalCost: 20000,
    maturityDate: DateTime.parse('2022-10-05T21:00:00.000Z'),
    buyPricePerUnit: 20000,
    valuationDate: DateTime.parse('2022-10-05T21:00:00.000Z'),
  );

  @override
  List<Object?> get props => [
        securityName,
        securityShortName,
        tradedExchange,
        brokerName,
        isin,
        category,
        country,
        currencyCode,
        investmentDate,
        marketValue,
        quantity,
        totalCost,
        maturityDate,
        buyPricePerUnit,
        valuationDate
      ];
}
