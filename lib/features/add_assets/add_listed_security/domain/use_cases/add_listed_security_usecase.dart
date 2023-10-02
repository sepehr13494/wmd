import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_listed_security/domain/repositories/listed_security_repository.dart';
import 'package:wmd/features/add_assets/core/data/models/country.dart';
import 'package:wmd/features/add_assets/core/data/models/currency.dart';
import 'package:wmd/features/add_assets/core/data/models/listed_security_name.dart';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';

class AddListedSecurityUseCase extends UseCase<AddAsset, Map<String, dynamic>> {
  final ListedSecurityRepository listedSecurityRepository;

  AddListedSecurityUseCase(this.listedSecurityRepository);
  @override
  Future<Either<Failure, AddAsset>> call(Map<String, dynamic> params) async {
    try {
      return await listedSecurityRepository
          .postListedSecurity(getAddListedSecurityParamsObj(params));
    } catch (e) {
      debugPrint("AddListedSecurityUseCase catch : ${e.toString()}");
      return const Left(AppFailure(message: "Something went wrong!"));
    }
  }

  static AddListedSecurityParams getAddListedSecurityParamsObj(params) {
    final marketValue = params['marketValue'].toString().replaceAll(',', '');
    final totalCost = params['totalCost'].toString().replaceAll(',', '');

    final ListedSecurityName name = params['name'];

    debugPrint("ListedSecurityName");

    final Map<String, dynamic> newMap = {
      ...params,
      "securityName": name.securityName,
      "securityShortName": name.securityShortName,
      "tradedExchange": name.tradedExchange,
      "isin": name.isin,
      "category": name.category,
      "marketValue": marketValue,
      "buyPricePerUnit": marketValue,
      "totalCost": totalCost,
    };

    debugPrint("newmap");
    debugPrint(newMap.toString());

    return AddListedSecurityParams.fromJson(newMap);
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
    required this.buyPricePerUnit,
    required this.quantity,
    required this.totalCost,
    this.maturityDate,
    this.couponRate,
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
  final double buyPricePerUnit;
  final double quantity;
  final double totalCost;
  final DateTime? maturityDate;
  final double? couponRate;

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
        investmentDate: DateTime.parse(json["investmentDate"].toString()),
        marketValue: json["marketValue"] != null ? double.tryParse(json["marketValue"]) : json["marketValue"],
        buyPricePerUnit: json["buyPricePerUnit"] != null ? double.tryParse(json["buyPricePerUnit"]) : json["buyPricePerUnit"],
        quantity: json["quantity"] != null
            ? double.tryParse(json["quantity"])
            : json["quantity"],
        totalCost: json["totalCost"] != null
            ? double.tryParse(json["totalCost"])
            : json["totalCost"],
        maturityDate: json["maturityDate"] != null
            ? DateTime.parse(json["maturityDate"].toString())
            : json["maturityDate"],
        couponRate: json["couponRate"] != null
            ? double.tryParse(json["couponRate"])
            : json["couponRate"],
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
        "valuationDate": investmentDate.toIso8601String(),
        "marketValue": marketValue,
        "buyPricePerUnit": buyPricePerUnit,
        "quantity": quantity,
        "totalCost": totalCost,
        "maturityDate": maturityDate != null
            ? maturityDate!.toIso8601String()
            : maturityDate,
        "couponRate": couponRate
      };

  static final tAddListedSecurityMap = {
    "name": ListedSecurityName.fromJson({
      "securityName": "Test Security Asset",
      "securityShortName": "Test",
      "tradedExchange": "test",
      "isin": "us209878",
      "category": "FixedIncome",
    }),
    "brokerName": "Abbot Downing",
    "country": Country(name: "USA", countryName: "USA"),
    "currencyCode": Currency(name: "USD", symbol: "USD"),
    "investmentDate": DateTime.parse('2022-10-05T21:00:00.000Z'),
    "marketValue": "30000",
    "buyPricePerUnit": "30000",
    "quantity": "3",
    "totalCost": "20000",
    "maturityDate": DateTime.parse('2022-10-05T21:00:00.000Z'),
    "couponRate": "10"
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
      marketValue: 30000.0,
      buyPricePerUnit: 30000.0,
      quantity: 3.0,
      totalCost: 20000.0,
      maturityDate: DateTime.parse('2022-10-05T21:00:00.000Z'),
      couponRate: 10.0);

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
    buyPricePerUnit,
        quantity,
        totalCost,
        maturityDate,
        couponRate
      ];
}
