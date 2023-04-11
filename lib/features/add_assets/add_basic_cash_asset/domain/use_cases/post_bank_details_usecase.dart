// import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/repositories/bank_repository.dart';
import 'package:wmd/features/add_assets/core/data/models/country.dart';
import 'package:wmd/features/add_assets/core/data/models/currency.dart';
import 'package:wmd/features/add_assets/core/domain/entities/add_asset_response.dart';

class PostBankDetailsUseCase extends UseCase<AddAsset, Map<String, dynamic>> {
  final BankRepository bankRepository;
  final LocalStorage localStorage;

  PostBankDetailsUseCase(this.bankRepository, this.localStorage);

  @override
  Future<Either<Failure, AddAsset>> call(Map<String, dynamic> params) async {
    try {
      final result = await bankRepository.postBankDetails(getBankSaveParamObj(params,localStorage));
      return result;
    } catch (e) {
      debugPrint("PostBankDetailsUseCase catch : ${e.toString()}");
      return const Left(AppFailure(message: "Something went wrong!"));
    }
  }

  static BankSaveParams getBankSaveParamObj(Map<String, dynamic> params,localStorage){
    final currentBal = params['currentBalance'] != null
        ? params['currentBalance'].toString().replaceAll(',', '')
        : params['currentBalance'];
    final ownerId = localStorage.getOwnerId();
    final newMap = {
      ...params,
      "currentBalance": currentBal != null ? double.parse(currentBal) : null,
      "owner": ownerId,
    };
    return BankSaveParams.fromJson(newMap);
  }
}

class BankSaveParams extends Equatable {
  const BankSaveParams({
    this.isActive,
    this.owner,
    required this.bankName,
    required this.country,
    this.description,
    required this.accountType,
    required this.currencyCode,
    this.currentBalance,
    this.isJointAccount,
    this.noOfCoOwners,
    this.ownershipPercentage,
    this.interestRate,
    this.startDate,
    this.endDate,
  });

  final bool? isActive;
  final String? owner;
  final String bankName;
  final String country;
  final String? description;
  final String accountType;
  final String currencyCode;
  final double? currentBalance;
  final bool? isJointAccount;
  final int? noOfCoOwners;
  final double? ownershipPercentage;
  final double? interestRate;
  final DateTime? startDate;
  final DateTime? endDate;

  factory BankSaveParams.fromJson(Map<String, dynamic> json) => BankSaveParams(
        isActive: json["isActive"],
        owner: json["owner"],
        bankName: json["bankName"],
        country: (json["country"] as Country).name,
        description: json["description"],
        accountType: json["accountType"],
        currencyCode: (json["currencyCode"] as Currency).symbol,
        currentBalance: json["currentBalance"],
        isJointAccount: json["isJointAccount"],
        noOfCoOwners: json["noOfCoOwners"],
        ownershipPercentage: json["ownershipPercentage"] != null
            ? double.tryParse(json["ownershipPercentage"])
            : json["ownershipPercentage"],
        interestRate: json["interestRate"] != null
            ? double.tryParse(json["interestRate"])
            : json["interestRate"],
        startDate: json["startDate"],
        endDate: json["endDate"],
      );

  Map<String, dynamic> toJson() => {
        "isActive": isActive ?? false,
        "owner": owner ?? ".",
        "bankName": bankName,
        "country": country,
        "description": description ?? ".",
        "accountType": accountType,
        "currencyCode": currencyCode,
        "currentBalance": currentBalance,
        "isJointAccount": isJointAccount ?? false,
        "noOfCoOwners": noOfCoOwners ?? 0,
        "ownershipPercentage": ownershipPercentage ?? 0.0,
        "interestRate": interestRate ?? 0.0,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
      };

  static final tBankFormMap = {
    'bankName': 'bank1',
    'country': Country(name: "USA", countryName: "USA"),
    'accountType': 'Saving account',
    'currencyCode': Currency(name: "USD", symbol: "USD"),
    'currentBalance': '100,000',
  };

  static const tBankSaveParams = BankSaveParams(
      bankName: "bank1",
      country: "USA",
      accountType: "Saving account",
      currencyCode: "USD",
      currentBalance: 100000.0,
      owner: "ownerId");

  @override
  List<Object?> get props => [
        isActive,
        owner,
        bankName,
        country,
        description,
        accountType,
        currencyCode,
        currentBalance,
        isJointAccount,
        noOfCoOwners,
        ownershipPercentage,
        interestRate,
        startDate,
        endDate
      ];
}
