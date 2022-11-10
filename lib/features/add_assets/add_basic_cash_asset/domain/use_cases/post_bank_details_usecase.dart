import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/entities/bank_save_response.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/repositories/bank_repository.dart';
import 'package:wmd/features/add_assets/core/data/models/country.dart';
import 'package:wmd/features/add_assets/core/data/models/currency.dart';

class PostBankDetailsUseCase extends UseCase<BankSaveResponse, Map<String, dynamic>> {
  final BankRepository bankRepository;

  PostBankDetailsUseCase(this.bankRepository);
  @override
  Future<Either<Failure, BankSaveResponse>> call(Map<String,dynamic> params) {
    //TODO: convert map into BankSaveParams and replace with tBankSaveParams
    return bankRepository.postBankDetails(BankSaveParams.tBankSaveParams);
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

  static const tBankFormMap = {
    'bankName': 'bank1',
    'description': 'cnncnc',
    'country': {'name': 'BL', 'countryName': 'Saint Barthelemy'},
    'accountType': 'Saving account',
    'currencyCode': {'value': 'USD', 'label': 'United States dollar'},
    'currentBalance': '100',
  };

  static const tBankSaveParams = BankSaveParams(
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
