import 'package:wmd/features/asset_detail/bank_account/domain/entity/bank_account_entity.dart';
import 'package:wmd/features/asset_detail/core/data/models/get_detail_response.dart';

class BankAccountResponse extends BankAccountEntity
    implements GetDetailResponse {
  const BankAccountResponse({
    required super.bankName,
    required super.description,
    required super.accountType,
    required super.currentBalance,
    required super.isJointAccount,
    required super.noOfCoOwners,
    required super.ownershipPercentage,
    required super.interestRate,
    required super.startDate,
    required super.endDate,
    required super.id,
    required super.type,
    required super.isActive,
    required super.country,
    required super.region,
    required super.currencyCode,
    required super.portfolioContribution,
    required super.holdings,
  });

  factory BankAccountResponse.fromJson(Map<String, dynamic> json) =>
      BankAccountResponse(
        bankName: json["bankName"] ?? '',
        description: json["description"] ?? '',
        accountType: json["accountType"] ?? '',
        currentBalance: json["currentBalance"],
        isJointAccount: json["isJointAccount"] ?? false,
        noOfCoOwners: double.tryParse(json['noOfCoOwners'].toString()) ?? 0,
        ownershipPercentage:
            double.tryParse(json['ownershipPercentage'].toString()) ?? 0,
        interestRate: double.tryParse(json['interestRate'].toString()) ?? 0,
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        id: json["id"] ?? '',
        type: json["type"] ?? '',
        isActive: json["isActive"] ?? false,
        country: json["country"] ?? '',
        region: json["region"] ?? '',
        currencyCode: json["currencyCode"] ?? '',
        portfolioContribution: json["portfolioContribution"].toDouble(),
        holdings: double.tryParse(json['holdings'].toString()) ?? 0,
      );

  @override
  List<Object?> get props => [
        bankName,
        description,
        accountType,
        currentBalance,
        isJointAccount,
        noOfCoOwners,
        ownershipPercentage,
        interestRate,
        startDate,
        endDate,
        id,
        type,
        isActive,
        country,
        region,
        currencyCode,
      ];

  static final tBankAccountResponse = {
    "bankName": "Isbank",
    "description": "Softtech",
    "accountType": "CurrentAccount",
    "currentBalance": 1071.0,
    "isJointAccount": false,
    "noOfCoOwners": 0,
    "ownershipPercentage": 0.0,
    "interestRate": 0.0,
    "startDate": null,
    "endDate": null,
    "id": "6e2bd58f-6d3f-46f1-9480-46a0f96cbeff",
    "type": "BankAccount",
    "isActive": true,
    "country": "TR",
    "region": "Asia",
    "currencyCode": "USD"
  };
}
