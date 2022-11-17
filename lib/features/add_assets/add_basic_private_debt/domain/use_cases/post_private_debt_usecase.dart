// import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/features/add_assets/add_basic_private_debt/domain/entities/private_debt_save_response.dart';
import 'package:wmd/features/add_assets/add_basic_private_debt/domain/repositories/private_debt_repository.dart';
import 'package:wmd/features/add_assets/core/data/models/country.dart';
import 'package:wmd/features/add_assets/core/data/models/currency.dart';

class PostPrivateDebtUseCase
    extends UseCase<PrivateDebtSaveResponse, Map<String, dynamic>> {
  final PrivateDebtRepository privateDebtRepository;
  final LocalStorage localStorage;

  PostPrivateDebtUseCase(this.privateDebtRepository, this.localStorage);
  @override
  Future<Either<Failure, PrivateDebtSaveResponse>> call(
      Map<String, dynamic> params) async {
    //TODO: convert map into BankSaveParams and replace with tBankSaveParams
    final currentBal = params['currentBalance'].toString().replaceAll(',', '');
    final ownerId = localStorage.getOwnerId();
    params['currentBalance'] = double.parse(currentBal);
    params['owner'] = ownerId;
    final privateDebtAssetParam = PrivateDebtSaveParams.fromJson(params);
    return await privateDebtRepository.postPrivateDebt(privateDebtAssetParam);
  }
}

class PrivateDebtSaveParams extends Equatable {
  const PrivateDebtSaveParams({
    this.isActive,
    this.owner,
    required this.bankName,
    required this.country,
    this.description,
    required this.accountType,
    required this.currencyCode,
    required this.currentBalance,
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
  final double currentBalance;
  final bool? isJointAccount;
  final int? noOfCoOwners;
  final double? ownershipPercentage;
  final double? interestRate;
  final DateTime? startDate;
  final DateTime? endDate;

  factory PrivateDebtSaveParams.fromJson(Map<String, dynamic> json) =>
      PrivateDebtSaveParams(
        isActive: json["isActive"],
        owner: json["owner"],
        bankName: json["bankName"],
        country: (json["country"] as Country).countryName,
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
        "owner": owner ?? "",
        "bankName": bankName,
        "country": country,
        "description": description ?? "",
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

  static const tPrivateDebtFormMap = {
    'bankName': 'bank1',
    'description': 'cnncnc',
    'country': {'name': 'BL', 'countryName': 'Saint Barthelemy'},
    'accountType': 'Saving account',
    'currencyCode': {'value': 'USD', 'label': 'United States dollar'},
    'currentBalance': '100',
  };

  static const tPrivateDebtSaveParams = PrivateDebtSaveParams(
    bankName: "Bank of America",
    country: "USA",
    accountType: "SAVING",
    currencyCode: "USD",
    currentBalance: 1000,
  );

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
