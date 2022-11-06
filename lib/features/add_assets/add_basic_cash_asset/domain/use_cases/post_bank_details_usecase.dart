import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/data/models/bank_save_response_model.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/entities/bank_save_response.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/repositories/bank_repository.dart';
import 'package:wmd/features/add_assets/core/data/models/country.dart';
import 'package:wmd/features/add_assets/core/data/models/currency.dart';

class PostBankDetailsUseCase extends UseCase<BankSaveResponse, BankSaveParams> {
  final BankRepository bankRepository;

  PostBankDetailsUseCase(this.bankRepository);
  @override
  Future<Either<Failure, BankSaveResponse>> call(BankSaveParams params) =>
      bankRepository.postBankDetails(params);
}

BankSaveParams bankSaveParamsFromJson(String str) =>
    BankSaveParams.fromJson(json.decode(str));

String bankSaveParamsToJson(BankSaveParams data) => json.encode(data.toJson());

class BankSaveParams extends Equatable {
  BankSaveParams({
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

  bool? isActive;
  String? owner;
  String bankName;
  String country;
  String? description;
  String accountType;
  String currencyCode;
  double currentBalance;
  bool? isJointAccount;
  int? noOfCoOwners;
  double? ownershipPercentage;
  double? interestRate;
  DateTime? startDate;
  DateTime? endDate;

  factory BankSaveParams.fromJson(Map<String, dynamic> json) => BankSaveParams(
        isActive: json["isActive"],
        owner: json["owner"],
        bankName: json["bankName"],
        country: (json["country"] as Country).countryName,
        description: json["description"],
        accountType: json["accountType"],
        currencyCode: (json["currencyCode"] as Currency).symbol,
        currentBalance: json["currentBalance"].toDouble(),
        isJointAccount: json["isJointAccount"],
        noOfCoOwners: json["noOfCoOwners"],
        ownershipPercentage: json["ownershipPercentage"].toDouble(),
        interestRate: json["interestRate"].toDouble(),
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

  static final tBankSaveParams = BankSaveParams(
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
