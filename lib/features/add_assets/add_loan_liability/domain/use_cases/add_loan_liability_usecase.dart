import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_loan_liability/domain/repositories/loan_liability_repository.dart';
import 'package:wmd/features/add_assets/core/data/models/currency.dart';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';

class AddLoanLiabilityUseCase extends UseCase<AddAsset, Map<String, dynamic>> {
  final LoanLiabilityRepository loanLiabilityRepository;

  AddLoanLiabilityUseCase(this.loanLiabilityRepository);
  @override
  Future<Either<Failure, AddAsset>> call(Map<String, dynamic> params) async {
    try {
      final loanAmountOutstanding =
          params['loanAmountOutstanding'].toString().replaceAll(',', '');
      final loanAmountSanctioned =
          params['loanAmountSanctioned'].toString().replaceAll(',', '');
      final monthlyPayment =
          params['monthlyPayment'].toString().replaceAll(',', '');

      final newMap = {
        ...params,
        "loanAmountOutstanding": loanAmountOutstanding,
        "loanAmountSanctioned": loanAmountSanctioned,
        "monthlyPayment": monthlyPayment,
      };

      final privateDebtAssetParam = AddLoanLiabilityParams.fromJson(newMap);
      return await loanLiabilityRepository
          .postLoanLiability(privateDebtAssetParam);
    } catch (e) {
      debugPrint("AddRealEstateUseCase catch : ${e.toString()}");
      return const Left(AppFailure(message: "Something went wrong!"));
    }
  }
}

class AddLoanLiabilityParams extends Equatable {
  const AddLoanLiabilityParams({
    required this.loanName,
    this.bankName,
    required this.loanType,
    required this.currencyCode,
    required this.loanAmountOutstanding,
    this.loanAmountSanctioned,
    this.startDate,
    this.endDate,
    this.rate,
    this.monthlyPayment,
    this.collateral,
    this.insurance,
  });

  final String loanName;
  final String? bankName;
  final String loanType;
  final String currencyCode;
  final double loanAmountOutstanding;
  final double? loanAmountSanctioned;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? rate;
  final double? monthlyPayment;
  final bool? collateral;
  final bool? insurance;

  factory AddLoanLiabilityParams.fromJson(Map<String, dynamic> json) =>
      AddLoanLiabilityParams(
        loanName: json["loanName"],
        bankName: json["bankName"],
        loanType: json["loanType"],
        currencyCode: (json["currencyCode"] as Currency).symbol,
        loanAmountOutstanding: json["loanAmountOutstanding"] != null
            ? double.tryParse(json["loanAmountOutstanding"])
            : json["loanAmountOutstanding"],
        loanAmountSanctioned: json["loanAmountSanctioned"] != null
            ? double.tryParse(json["loanAmountSanctioned"])
            : json["loanAmountSanctioned"],
        startDate: json["startDate"] != null
            ? DateTime.parse(json["startDate"].toString())
            : json["startDate"],
        endDate: json["endDate"] != null
            ? DateTime.parse(json["endDate"].toString())
            : json["endDate"],
        rate:
            json["rate"] != null ? double.tryParse(json["rate"]) : json["rate"],
        monthlyPayment: json["monthlyPayment"] != null
            ? double.tryParse(json["monthlyPayment"])
            : json["monthlyPayment"],
        collateral: json["collateral"],
        insurance: json["insurance"],
      );

  Map<String, dynamic> toJson() => {
        "loanName": loanName,
        "bankName": bankName,
        "loanType": loanType,
        "currencyCode": currencyCode,
        "loanAmountOutstanding": loanAmountOutstanding,
        "loanAmountSanctioned": loanAmountSanctioned,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "rate": rate,
        "monthlyPayment": monthlyPayment,
        "collateral": collateral,
        "insurance": insurance
      };

  static final tAddLoanLiabilityMap = {
    "loanName": "loantest",
    "bankName": "test",
    "loanType": "Home",
    "currencyCode": Currency(name: "USD", symbol: "USD"),
    "loanAmountOutstanding": "500000",
    "loanAmountSanctioned": "700000",
    "startDate": DateTime.parse('2022-10-05T21:00:00.000Z'),
    "endDate": DateTime.parse('2022-10-05T21:00:00.000Z'),
    "rate": "5",
    "monthlyPayment": "50000",
    "collateral": true,
    "insurance": true
  };

  static final tAddLoanLiabilityParams = AddLoanLiabilityParams(
      loanName: "investmentName",
      bankName: "Residential",
      loanType: "test",
      currencyCode: "USD",
      loanAmountOutstanding: 40000,
      loanAmountSanctioned: 20000,
      startDate: DateTime.parse('2022-10-05T21:00:00.000Z'),
      endDate: DateTime.parse('2022-10-05T21:00:00.000Z'),
      rate: 30,
      monthlyPayment: 30000,
      collateral: true,
      insurance: false);

  @override
  List<Object?> get props => [
        loanName,
        bankName,
        loanType,
        currencyCode,
        loanAmountOutstanding,
        loanAmountSanctioned,
        startDate,
        endDate,
        rate,
        monthlyPayment,
        collateral,
        insurance
      ];
}
