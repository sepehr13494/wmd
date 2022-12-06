import 'package:wmd/features/asset_detail/bank_account/domain/entity/bank_account_entity.dart';
import 'package:wmd/features/asset_detail/core/data/models/get_detail_response.dart';

class BankAccountResponse extends BankAccountEntity
    implements GetDetailResponse {
  const BankAccountResponse(
    String? bankName,
    String? description,
    String? accountType,
    double? currentBalance,
    bool? isJointAccount,
    double? noOfCoOwners,
    double? ownershipPercentage,
    double? interestRate,
    String? startDate,
    String? endDate,
    String? id,
    String? type,
    bool? isActive,
    String? country,
    String? region,
    String? currencyCode,
  ) : super(
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
        );

  factory BankAccountResponse.fromJson(Map<String, dynamic> json) {
    final bankName = json['bankName']?.toString();
    final description = json['description']?.toString();
    final accountType = json['accountType']?.toString();
    final currentBalance =
        double.tryParse(json['currentBalance'].toString()) ?? 0;
    final isJointAccount = json['isJointAccount'];
    final noOfCoOwners = double.tryParse(json['noOfCoOwners'].toString()) ?? 0;
    final ownershipPercentage =
        double.tryParse(json['ownershipPercentage'].toString()) ?? 0;
    final interestRate = double.tryParse(json['interestRate'].toString()) ?? 0;
    final startDate = json['startDate']?.toString();
    final endDate = json['endDate']?.toString();
    final id = json['id']?.toString();
    final type = json['type']?.toString();
    final isActive = json['isActive'];
    final country = json['country']?.toString();
    final region = json['region']?.toString();
    final currencyCode = json['currencyCode']?.toString();
    return BankAccountResponse(
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
    );
  }

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
